$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$robloxTypes = Join-Path $env:TEMP "globalTypes.PluginSecurity.d.luau"

Push-Location $repoRoot

try {
    Invoke-WebRequest "https://luau-lsp.pages.dev/type-definitions/globalTypes.PluginSecurity.d.luau" -OutFile $robloxTypes
    & (Join-Path $PSScriptRoot "generate-sourcemap.ps1")

    luau-lsp analyze `
        --definitions:@roblox=$robloxTypes `
        --platform=roblox `
        --sourcemap=sourcemap.json `
        --settings=.vscode/settings.json `
        --no-strict-dm-types src
}
finally {
    Pop-Location
}

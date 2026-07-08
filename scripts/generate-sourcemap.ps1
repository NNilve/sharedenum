$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Push-Location $repoRoot

try {
    rojo sourcemap --include-non-scripts default.project.json --output sourcemap.json
}
finally {
    Pop-Location
}

# Project Overview
This module enables modules to shorten repeated, literal strings to 1 byte where string interning cannot be applied, such as:
- Remote Events or Functions
- Instance Attributes
- Storing Strings in buffer
Achieving reduced network bandwidth usage and memory usage
This utility library is intended to be used in Roblox.

String indices is guanteed to be same between client and server, but not between other servers.

## Style Guides
When writing Luau code, make sure to check `docs/style-guide.md`.

## Luau-lsp Type Analysis
Run type analysis from the repository root. The standalone CLI does not download Roblox types, so first download the same `PluginSecurity` definitions used by the VS Code extension, regenerate the Rojo sourcemap, and then analyze `src`:

```powershell
$RobloxTypes = Join-Path $env:TEMP 'globalTypes.PluginSecurity.d.luau'
Invoke-WebRequest 'https://luau-lsp.pages.dev/type-definitions/globalTypes.PluginSecurity.d.luau' -OutFile $RobloxTypes

rojo sourcemap --include-non-scripts default.project.json --output sourcemap.json
luau-lsp analyze --definitions:@roblox=$RobloxTypes --platform=roblox --sourcemap=sourcemap.json --settings=.vscode/settings.json --no-strict-dm-types src
```

Do not pass `--no-flags-enabled`: this repository uses the feature-gated `const` syntax. Fix every reported warning or error, then rerun the command until it exits successfully.

## Git / PR Rules
- **Type Analysis**: Before committing, run the Luau-lsp analysis procedure above.
- **Linting**: When Type Analysis is successful, run `selene <list_of_files>`. If errors or warnings exist, fix that, and do this again.
- **Formatting**: If Linting result has no errors or warnings, run `stylua <list_of_files>`.

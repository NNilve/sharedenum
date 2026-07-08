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
Run the repository scripts from the repository root instead of copying the commands manually.

- On Windows, use PowerShell:

```powershell
.\scripts\generate-sourcemap.ps1
.\scripts\type-analysis.ps1
```

- On Linux or macOS, use bash:

```bash
./scripts/generate-sourcemap.sh
./scripts/type-analysis.sh
```

The type analysis script downloads the same `PluginSecurity` definitions used by the VS Code extension, regenerates the Rojo sourcemap, and then runs Luau type analysis against `src`.

Do not pass `--no-flags-enabled`: this repository uses the feature-gated `const` syntax. Fix every reported warning or error, then rerun the command until it exits successfully.

## Git / PR Rules
- **Type Analysis**: Before committing, run the appropriate script for your operating system: `./scripts/type-analysis.ps1` on Windows or `./scripts/type-analysis.sh` on Linux/macOS.
- **Linting**: When Type Analysis is successful, run `selene <list_of_files>`. If errors or warnings exist, fix that, and do this again.
- **Formatting**: If Linting result has no errors or warnings, run `stylua <list_of_files>`.

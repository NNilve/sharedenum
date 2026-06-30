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

## Git / PR Rules
- **Type Analysis**: Before commiting, run `luau-lsp analyze <list_of_files>`, If errors or warnings exist, fix that, and do this again.
- **Linting**: When Type Analysis is successful, run `selene <list_of_files>`. If errors or warnings exist, fix that, and do this again.
- **Formatting**: If Linting result has no errors or warnings, run `stylua <list_of_files>`.
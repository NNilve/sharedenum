#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH='' cd -- "$script_dir/.." && pwd)
roblox_types="${TMPDIR:-/tmp}/globalTypes.PluginSecurity.d.luau"

cd "$repo_root"
curl -fsSL "https://luau-lsp.pages.dev/type-definitions/globalTypes.PluginSecurity.d.luau" -o "$roblox_types"
"$script_dir/generate-sourcemap.sh"

luau-lsp analyze \
  --definitions:@roblox="$roblox_types" \
  --platform=roblox \
  --sourcemap=sourcemap.json \
  --settings=.vscode/settings.json \
  --no-strict-dm-types src

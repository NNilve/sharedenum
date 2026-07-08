#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH='' cd -- "$script_dir/.." && pwd)

cd "$repo_root"
rojo sourcemap --include-non-scripts default.project.json --output sourcemap.json

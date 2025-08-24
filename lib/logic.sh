#!/usr/bin/env bash
# lib/logic.sh

set -euo pipefail

maybe_validate_root() {
  local path="$1"
  [[ -d "$path" ]] || return 1
}

maybe_find_empty_dirs() {
  local root="$1"
  [[ -d "$root" ]] || return 1
  find "$root" -type d -empty 2>/dev/null || return 1
}

maybe_touch_keep() {
  local dir="$1"
  [[ -d "$dir" ]] || return 1
  touch "$dir/.keep" 2>/dev/null || return 1
}


#!/usr/bin/env bash
# main.sh

set -euo pipefail

source "$(dirname "$0")/lib/logic.sh"
source "$(dirname "$0")/lib/io.sh"

ARGS=()
DRY_RUN=false

parse_args_io() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run) DRY_RUN=true ;;
      -h|--help) show_help_io; exit 0 ;;
      *) ARGS+=("$1") ;;
    esac
    shift
  done
}

main() {
  parse_args_io "$@"

  local root="${ARGS[0]:-}"
  if ! maybe_validate_root "$root"; then
    log_error_io "Invalid root directory: $root"
    show_help_io
    exit 1
  fi

  if ! empty_dirs="$(maybe_find_empty_dirs "$root")"; then
    log_warn_io "No empty directories found under $root"
    exit 0
  fi

  echo "$empty_dirs" | while read -r dir; do
    if $DRY_RUN; then
      log_info_io "Would mark: $dir"
    else
      if ! maybe_touch_keep "$dir"; then
        log_error_io "Failed to mark: $dir"
      else
        log_info_io "Marked: $dir"
      fi
    fi
  done
}

main "$@"


#!/usr/bin/env bash
# lib/io.sh

set -euo pipefail

log_info_io()  { echo "[INFO] $*" >&2; }
log_warn_io()  { echo "[WARN] $*" >&2; }
log_error_io() { echo "[ERROR] $*" >&2; }

show_help_io() {
  cat <<EOF
Usage: mark-empty-dirs <root> [--dry-run]

Marks empty directories with .keep files.

Options:
  --dry-run   Show what would be marked without writing files
  -h, --help  Show this help message
EOF
}


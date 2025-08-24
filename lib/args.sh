# lib/args.sh

parse_args() {
  local path=""
  local dry_run=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p|--path) path="$2"; shift 2 ;;
      -d|--dry-run) dry_run=true; shift ;;
      -h|--help) show_help; exit 0 ;;
      *) log_error "Unknown option: $1"; show_help; exit 1 ;;
    esac
  done

  echo "([path]=\"$path\" [dry_run]=\"$dry_run\")"
}

validate_args() {
  local path="$1"
  [[ -z "$path" ]] && log_error "--path is required" && exit 1
  [[ ! -d "$path" ]] && log_error "'$path' is not a directory" && exit 1
}



# === {{CMD}}  spec-run  my-shell-script.sh
run-specs () {
  local FILE
  FILE="$1"; shift
  source "$FILE"
  specs
}


# === {{CMD}}  spec-run  my-shell-script.sh
spec-run () {
  local FILE
  FILE="$1"; shift
  source "$FILE"
  specs
}

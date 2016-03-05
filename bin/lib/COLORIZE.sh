
specs () {
  bash_setup COLORIZE "$(tput bold)"  "this is {{bold}}"
}

# === {{CMD}}  "\\e[0;33m"  "my {{text}}"
COLORIZE () {
  local ESCAPED_COLOR
  local COLOR_OFF="\\e\[0m"
  ESCAPED_COLOR="$1"; shift
  local TEXT="$@"
  echo -e "$@" | perl -p -e "s/\{\{(.+)\}\}/${ESCAPED_COLOR}\1${COLOR_OFF}/g"
}

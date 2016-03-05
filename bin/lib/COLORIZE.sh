
specs () {
  bash_setup COLORIZE "$(tput bold)"  "this is {{bold}}"
}

# === {{CMD}}  "MY_ESCAPE_SEQUENCE"  "my {{text}}"
COLORIZE () {
  local ESCAPED_COLOR
  local COLOR_OFF="\\e\[0m"
  ESCAPED_COLOR="$1"; shift
  local TEXT="$@"
  echo -e "$@" | perl -p -e "s/\{\{(.+)\}\}/${ESCAPED_COLOR}\1${COLOR_OFF}/g"
}

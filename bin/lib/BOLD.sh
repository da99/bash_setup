
# === {{CMD}}  "my string that is {{ bold }}"

specs () {
  bash_setup BOLD  "my string that is {{ bold }}"
  bash_setup BOLD  "this is also orange:  {{my {bold}}}"
}

source $THIS_DIR/bin/lib/COLORIZE.sh
BOLD () {
  COLORIZE "$(tput bold)" "$@"
}





# === {{CMD}}  "my string that is {{ orange }}"

specs () {
  bash_setup ORANGE  "my string that is {{ orange }}"
  bash_setup ORANGE  "this is also orange:  {{my {text}}}"
}

source $THIS_DIR/bin/lib/COLORIZE.sh
ORANGE () {
  local Orange='\e[0;33m'
  local BOrange='\e[1;33m'
  COLORIZE "$BOrange" "$@"
}




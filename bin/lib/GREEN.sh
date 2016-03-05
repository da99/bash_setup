specs () {
  bash_setup GREEN "=== {{PASSED}}: specs"
  bash_setup GREEN "=== {{PASSED}}dddd: specs"
  bash_setup GREEN "=== my{{PASSED}}dddd: specs"
  bash_setup GREEN "=== {{Pass}}: specs"
  bash_setup GREEN "=== {{PASS}}: specs"
  bash_setup GREEN "=== {{PASSED}}: specs"
}

source $THIS_DIR/bin/lib/COLORIZE.sh
# === {{CMD}}  "{{Passed}}: my text"
# === {{CMD}}  "mY {{teSts}} aLl PaSs"
GREEN () {
  local Green='\e[0;32m'
  local BGreen='\e[1;32m'
  COLORIZE "$BGreen" "$@"
} # === end function


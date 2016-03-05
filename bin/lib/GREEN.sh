
# === {{CMD}}  "Passed: my text"
# === {{CMD}}  "mY teSts aLl PaSs"
# === {{CMD}}  "keyword"  "my text with keyword"
GREEN () {
  local Green='\e[0;32m'
  local BGreen='\e[1;32m'
  local Color_Off='\e[0m'
  local keyword=""
  local text=""
  local arg1
  local arg2

  arg1="$1"; shift

  if [[ -z "$@" ]]; then
    text="$arg1"
  else
    keyword="$arg1"
    text="$@"
  fi

  if [[ -z "$keyword" ]]; then
    echo -e "$text" | perl -p -e "s/\b(Pass|Passed)\b/\\e\[1;32m\1\\e\[0m/ig"
  else
    echo -e "${text//$keyword/${BGreen}$keyword${Color_Off}}"
  fi
} # === end function

# TODO: specs
# bash_setup GREEN "=== PASSED: specs"
# bash_setup GREEN "=== PASSEDdddd: specs"
# bash_setup GREEN "=== myPASSEDdddd: specs"
# bash_setup GREEN "=== Pass: specs"
# bash_setup GREEN "=== PASS: specs"
# bash_setup GREEN specs "=== PASSED: specs"


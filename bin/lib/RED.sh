
# === {{CMD}}  "my text"
# === {{CMD}}  "keyword"  "my text with keyword"
RED () {
  local BRed='\e[1;31m'
  local Red='\e[0;31m'
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
    text="${text//Failed/${BRed}Failed${Color_Off}}"
    text="${text//FAILED/${BRed}FAILED${Color_Off}}"
    echo -e "${text}"
  else
    echo -e "${text//$keyword/${BRed}$keyword${Color_Off}}"
  fi
} # === end function

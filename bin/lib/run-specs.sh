
# === {{CMD}}  spec-run  my-shell-script.sh
run-specs () {
  if [[ -z "$@" ]]; then
    while read FILE; do
      bash_setup BOLD "=== Specs: {{$FILE}}"
      bash_setup run-specs "$FILE"
      echo ""
    done < <(grep -r -l -P '^specs\s*\(\)' bin/lib)

    files="$(grep -r -l -v -P -z '^specs\s*\(\)' bin/lib || :)"
    if [[ -n "$files" ]]; then
      bash_setup ORANGE "=== Files {{without}} specs:"
      echo -e "$files"
      echo ""
    fi

    bash_setup GREEN "==== All specs {{passed}}."
    return 0
  fi

  local FILE_ARG="$1"; shift
  local FILE

  if [[ -f "$FILE_ARG" ]]; then
    FILE="$FILE_ARG"
  else
    FILE="$(find bin/lib -type f -iname "$FILE_ARG")"
  fi

  source "$FILE"

  # NOTE: We can't use 'specs || report-fail'
  #  because of this:
  #  http://stackoverflow.com/questions/4072984/set-e-in-a-function
  trap 'report-fail $?' EXIT
  specs
  trap - EXIT

}

report-fail () {
  stat=$1; shift
  if [[ "$stat" -ne "0" ]]; then
    bash_setup RED "=== Spec {{Failed}} with exit status: $stat"
  fi
  exit $stat
}

should-pass () {
  local stat
  set +e
  eval "$@"
  stat=$?
  set -e

  if [[ "$stat" -eq "0" ]]; then
    bash_setup GREEN  "=== {{Passed}}: $@"
  else
    bash_setup RED "=== {{Failed}}: exit $stat: $@"
  fi
}

should-exit () {
  local expect="$1"; shift
  local actual
  local cmd="$@"

  set +e
  eval "$@"
  actual="$?"
  set -e

  if [[ "$expect" -eq "$actual" ]]; then
    bash_setup GREEN  "=== {{Passed}}: exit $expect: $cmd"
  else
    bash_setup RED "=== Spec wanted status $expect but got {{$actual}}"
  fi
}



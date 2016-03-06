
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
  specs || {
    stat=$?;
    bash_setup RED "=== Spec {{Failed}} with exit status: $stat";
    exit $stat;
  }
}


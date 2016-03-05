
# === {{CMD}}  spec-run  my-shell-script.sh
run-specs () {
  if [[ -z "$@" ]]; then
    while read FILE; do
      bash_setup BOLD "=== Specs: {{$FILE}}"
      bash_setup run-specs "$FILE" || \
        { stat=$?; bash_setup RED "=== Spec {{Failed}} with exit status: $stat"; exit $stat; }
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

  local FILE
  FILE="$1"; shift
  source "$FILE"
  specs
}

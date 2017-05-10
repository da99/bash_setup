
# === {{CMD}}  # Used for testing bash_setup
test-and-watch () {
    $0 test-bash_setup || :

    echo "=== Watching $THIS_DIR:"
    while read -r CHANGE; do
      dir=$(echo "$CHANGE" | cut -d' ' -f 1)
      op=$(echo "$CHANGE" | cut -d' ' -f 2)
      path="${dir}$(echo "$CHANGE" | cut -d' ' -f 3)"
      file="$(basename $path)"

      if [[ ! -f "$path" ]]; then
        continue
      fi

      if [[ "$(realpath -m "$path")" == "$(realpath -m "$0")" ]]; then
        echo ""
        echo "=== Reloading..."
        break
      fi

      echo "=== $CHANGE ($path)"
    done < <(inotifywait --quiet --monitor --event close_write --exclude .git/ -r "$THIS_DIR")
    $0 $ARGS
} # === end function

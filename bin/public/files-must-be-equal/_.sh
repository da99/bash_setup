
# === {{CMD}}  NAME  "file1"  "file2"
files-must-be-equal () {
  NAME="$1"; shift
  FILE1="$1"; shift
  FILE2="$1"; shift
  # if [[ -s "$FILE1" ]] && ! diff <(my_bash trim-file "$FILE1") <(my_bash trim-file "$FILE2"); then
  if [[ -s "$FILE1" ]] && ! diff <(my_bash trim-file "$FILE1") <(my_bash trim-file "$FILE2"); then
    sh_color RED "=== $NAME {{Failed}}:"
    sh_color BOLD "{{      === Actual: =====}} $FILE2"
    cat "$FILE2"
    sh_color BOLD "{{      === Expected: ===}} $FILE1"
    cat "$FILE1"
    sh_color BOLD "{{      =================}}"
    exit 1
  fi
} # === end function

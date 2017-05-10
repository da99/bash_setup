
# === {{CMD}}   "$FILE"
remove-empty-lines () {
  grep -v --extended-regexp '^\s*$' $@
} # === end function

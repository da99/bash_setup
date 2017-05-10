
# === {{CMD}} path/to/file
# === cat path/to/file | {{CMD}}
trim-file () {
  grep  -Pzo '(?s)\A[\s\n]*\K(.+?)(?=[\s\n]*\Z)' $@
} # === end function

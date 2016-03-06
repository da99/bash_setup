
# === {{CMD}}  name
# === Creates bin/lib/name.sh
new-func () {
  local name="$1"; shift
  local FILE="bin/lib/${name}.sh"

  mkdir -p bin/lib
  if [[ -s "$FILE" ]]; then
    bash_setup RED "=== File already {{exists}}: $FILE"
    exit 1
  fi

  echo "" >> "$FILE"
  echo "# === {{CMD}} ..." >> "$FILE"
  echo "${name} () {" >> "$FILE"
  echo "} # === end function" >> "$FILE"
  bash_setup BOLD "=== Created: {{${FILE}}}"
}

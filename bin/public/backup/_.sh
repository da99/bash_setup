
# === {{CMD}}  filename
# === Copies filename to: filename.backup
backup () {
  file="$1"
  backup="$1.backup"
  if [[ -f "$backup" ]]; then
    echo "Backup file already exists: $backup" 1>&2
    exit 1
  fi
  set '-x'
  cp -i "$file" "$backup"
} # === end function

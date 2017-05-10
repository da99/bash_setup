
# === {{CMD}}  filename
# === Moves filename.backup to: filename
restore () {
  file="$1"
  backup="$1.backup"
  if [[ ! -f "$backup" ]]; then
    echo "Backup file does *not* exist: $backup" 1>&2
    exit 1
  fi
  set '-x'
  { [[ -f "$file" ]] && trash-put $file; } || :
  mv -i "$backup" "$file"
} # === end function

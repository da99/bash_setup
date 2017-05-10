
# === {{CMD}}  path  start
# === See: https://docs.python.org/2/library/os.path.html#os.path.relpath
rel-path () {
  python -c "import os.path; print os.path.relpath('$1', '$2')"
} # === end function

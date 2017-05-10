
# === {{CMD}}
# === Finds any .pacnew, .pacsave, etc.
pacnew () {
  # From: https://bbs.archlinux.org/viewtopic.php?id=193477
  find /etc/ \( -name \*.pacnew -o -name \*.pacorig -o -name \*.pacsave \) 2> /dev/null
} # === end function

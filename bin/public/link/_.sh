
# === {{CMD}}  source(old)  dest(new)
link () {
  local orig=$1
  local target=$2

  # IF broken link exists, remove
  if [[ -h "$target" && ! -e "$(readlink $target)" ]]; then
    echo -e "\n!!! trashing broken link: $target\n"
    trash-put $target
  fi

  # --- IF it does NOT exit?
  if [[ ! -e "$target" ]]
  then # --- create link
    ln -s $orig $target
    sh_color GREEN "--- Linked: $orig {{$target}}"
  else

    # --- IF is a sym link?
    if [[ -h "$target" && "$(readlink -f "$target")" == "$(readlink -f $orig)" ]]
    then
      echo "Already sym link: $target"

    else
      sh_color RED -e "\n=== Check existing object: {{$target}}"
      echo -e "\n diff $orig $target\n\n" 1>&2
      exit 1

    fi # --- valid sym link?
  fi # --- ! -e
} # === end function

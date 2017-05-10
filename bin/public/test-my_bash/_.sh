
# === {{CMD}}
test-my_bash () {
    TEMP="/tmp/test-bash_setup"
    rm -rf "$TEMP"; mkdir -p "$TEMP"

    # === dirs-are-equal ======================
    DIR="$TEMP/dirs-are-equal"
    mkdir -p "$DIR"
    dir1="$DIR/temp1"; mkdir -p "$dir1"
    dir2="$DIR/temp2"; mkdir -p "$dir2"
    $0 dirs-are-equal "$dir1" "$dir2" || { stat=$?; sh_color RED "!!! {{Failed}} ($stat): empty dir == empty dir"; exit $stat; }

    touch "$dir1/file1"; touch "$dir2/file1"
    $0 dirs-are-equal "$dir1" "$dir2" || { stat=$?; sh_color RED "!!! {{Failed}} ($stat): empty file == empty file"; exit $stat; }

    touch "$dir1/file2"; touch "$dir2/file2-1"
    if $0 dirs-are-equal "$dir1" "$dir2" > $TEMP/output; then
      sh_color RED "!!! {{Failed}} different file name: file2 == file2-1"
      exit 1
    fi
    rm "$dir1/file2" "$dir2"/file2*

    echo "three" > "$dir1/file3";
    echo "three" > "$dir2/file3";
    if ! $0 dirs-are-equal "$dir1" "$dir2" > $TEMP/output; then
      sh_color RED "!!! {{Failed}} same names, same content: file3 == file3"
      cat $TEMP/output 1>&2
      exit 1
    fi

    echo "four"     > "$dir1/file4";
    echo "not four" > "$dir2/file4";
    if $0 dirs-are-equal "$dir1" "$dir2" &> $TEMP/output; then
      sh_color RED "!!! {{Failed}} same names, different content: file4 == file4"
      cat $TEMP/output 1>&2
      exit 1
    fi
    # === dirs-are-equal DONE =================

    sh_color GREEN "=== {{Testing}} is done"
} # === end function

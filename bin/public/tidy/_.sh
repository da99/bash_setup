
# === {{CMD}} 
tidy () {
  cd /progs
  if [[ ! -d tidy-html5 ]]; then
    git clone https://github.com/htacg/tidy-html5
  fi
  cd tidy-html5
  git pull
  cd build/cmake
  sudo apt-get install cmake xsltproc
  cmake ../.. -DCMAKE_INSTALL_PREFIX=/progs/tidy-html5 -DBUILD_SHARED_LIB:BOOL=OFF
  make
  make install
} # === end function

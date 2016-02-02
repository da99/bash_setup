
if test -n "$INSIDE_EMACS"; then
  export TERMINFO="$(echo /usr/share/emacs/*/etc/e | head -n 1)"
  export TERM=eterm-color
else
  export TERM=xterm-256color
fi

# Add the following to ~/.bashrc
# if [ -f ~/imp/MyLife/prefs/.bashrc ]; then
   # . ~/imp/MyLife/prefs/.bashrc
# fi

MY_LIFE="/apps/my_uni/MyLife"
force_color_prompt=yes
PYTHONDONTWRITEBYTECODE="iHATEpycFiles"
PYTHONPATH="$(which python3)"
JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java"





export GO_DIR_UUID=miniuni.com/da99
export GOROOT=/progs/golang/go
export GOPATH="/apps/go_setup/workspace"


latest () {
  echo "$@" | tr ' ' "\n" | sort -V | tail -n 1
}


# Haskell =================
haskell_home () {
  local cabal="$(latest /opt/cabal/*/bin )"
  local ghc="$(latest /opt/ghc/*/bin )"
  echo "$HOME/.cabal/bin:$cabal:$ghc"
}

# Elm ====================
elm_home () {
  latest /progs/elm/Elm-Platform/*/.cabal-sandbox/bin
}

alias g='pgrep -a '
alias use_elm='use_nvm && \
  export ELM_HOME="$(elm_home)" && \
  export PATH="$PATH:$(haskell_home):$ELM_HOME" && \
  echo "Elm version: $(elm-repl -v)";'

# Lua =====================================
# if [[ -n $(command -v luarocks) ]]; then
  # `luarocks path`
# fi

# mu_mind_paths=/apps/mu_mind/bin/paths.sh

# if [[ -f $mu_mind_paths ]]
# then
  # . $mu_mind_paths
# fi

alias up="cd /apps/boot_ups && git status"
alias mu="cd /apps/mu_mind  && git status"
alias backup="git push origin master && git push backup master"

# More info: http://www.cyberciti.biz/faq/ubuntu-linux-user-profile-bash-configuration/

# From: http://buzaz.com/index.php/2010/01/03/how-to-build-a-ruby-gem/
export GEM_PRIVATE_KEY='/home/da01/.ssh/gem-private_key.pem'
export GEM_CERTIFICATE_CHAIN='/home/da01/.ss/gem-public_cert.pem'

export EDITOR="$(command -v vim)"


# Custom functions and aliases.
function gem_install () { bash -c "gem install $1 --no-rdoc --no-ri && rbenv rehash"; }


function chromy () { chromium-browser "http://localhost/cgi-bin/man/man2html?query=$1"; }

alias my_prefs="cd  $MY_LIFE/MyRecipes"
alias deploy_db="sudo -u postgres psql -U deploy_db okdoki -h localhost"
alias use_ruby='{ [[ "$(which ruby)" == /progs/* ]]  || { export PATH=/progs/ruby/current/bin:$PATH && which ruby && ruby -v; echo ""; }; }'
alias use_nvm=' { [[ "$(type node 2>/dev/null)" == *progs/* ]]  || { source /progs/nvm/nvm.sh && nvm use --delete-prefix node; }; } '
alias use_elixir='{ test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"; }'


# alias coffee_watch='coffee --output lib/ -cw src/'
# alias coffee_mocha="mocha  --watch --compilers coffee:coffee-script"
# alias brake='bundle exec rake '
# alias reload_tint2='killall -SIGUSR1 tint2'
# alias pen='gvim 2>/dev/null'
# alias pen="UBUNTU_MENUPROXY=0 gvim"
alias be='bundle exec  '
alias mpref="vim -R $MY_LIFE/MyRecipes/main.txt"
alias un.tar.gz='tar xvfz'
alias un.tar='tar xvf'

export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

export DB_MEGAUNI_USER="megauni_user"
export DB_MEGAUNI_PASSWORD="pswd-94-pg"

export DB_NAME="megauni_db"
export DB_USER="$DB_MEGAUNI_USER"
export DB_PASSWORD="$DB_MEGAUNI_PASSWORD"
export DATABASE_URL="postgres://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME"

export SESSION_SECRET="j56xveiz0gR08rpBBDlRMHcZn50Jb9/x/+LTCskUMn0v4x2V/c+1zqGVY48PogpB"
export ENCRYPT_SALT="CtgY2NkB"
export SIGN_SALT="9vblSVcU"

export IS_DEV="helya"




GIT_P="/apps/dot_files/dots/.git-prompt.sh"
if [ -f "$GIT_P" ]
then
  source "$GIT_P"

  git_branch_name () {
    val="$(__git_ps1)"
    if [[ -n "$val" && "$val" != *"(master)"* ]]; then
      #echo -e "\[\033[00;32m\]${val}\[\033[00m\]"
      echo -e " $(tput setab 3)$(tput setaf 7)$(tput bold)$(echo $val | tr -d ' ')$(tput sgr0)"
    else
      echo -e "$(tput setaf 2)$val$(tput sgr0)"
    fi
  }

  if [[ "$(whoami)" == "root" ]]; then
    COLORED_PROMPT='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]\[\033[01;32m\]@\h\[\033[00m\]:\[\033[01;38m\]\w\[\033[00m\]\[\033[01;32m\]$(git_branch_name)\[\033[00m\] \$\n'
  else
    COLORED_PROMPT='${debian_chroot:+($debian_chroot)}\[\033[00;36m\]\u@\h\[\033[00m\]:\[\033[00;32m\]\w\[\033[00m\]$(git_branch_name) \$\n|-> '
  fi
else
  COLORED_PROMPT='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;38m\]\w\[\033[00m\] \$\n'
fi

vim()
{
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}


PS1="$COLORED_PROMPT"



### Added by the Heroku Toolbelt

# ------- Aliases to APPS --------------------------

cd_and_git_status () {
  if [[ "$PATH" != *github/bin* ]]; then
    export PATH="$PATH:/progs/github/bin"
  fi

  dir=$1
  shift
  if [[ "$@" == "" ]]; then
    cd "$dir"
    git status
    use_all
  else
    name="$(basename $dir)"
    /apps/$name/bin/$name "$@"
  fi
}

alias "e1"="echo e one;"
use_all () {
  [[ -f Gemfile ]] && use_ruby
  [[ -f mix.exs ]] && use_elixir
  # [[ -f bower.json || -d node_modules || -f package.json ]] && use_nvm
}
use_all

shopt -s nullglob
for d in /apps/*
do
  alias "$(basename $d)"="cd_and_git_status $d"
done
shopt -u nullglob

# ---------------------------------------------------
alias create_ssh_key='ssh-keygen -t rsa -b 4096'
ssh_add_all () {
  ssh-add ~/.ssh/keys/bitbucket
  ssh-add ~/.ssh/keys/github
}

# ---------------------------------------------------
export GITHUB_USER="da99"
if [[ "$PATH" != *github/bin* ]]; then
  export PATH="$PATH:/progs/github/bin"
fi

# ---------------------------------------------------
use_opa () {
  source $HOME/.bashrc.ocaml
}

# ---------------------------------------------------
# if [ -f ~/.bashrc.orig ]; then
#  . ~/.bashrc.orig
# fi
# If not running interactively, don't do anything

[[ $- != *i* ]] && return

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
alias ls='ls --color=auto'
alias grep='grep --color=auto'
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


bind '"\t":menu-complete'


if [ ! -e $HOME/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  ~/.fzf/install
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


bash_includes () {
  while read -r FILE
  do
    source $FILE
  done < <(find /apps/dot_files/dots/bash_includes/ -type f)
}
bash_includes
export GTK_OVERLAY_SCROLLING=0

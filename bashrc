##################################
# OS X and Linux Common Settings #
##################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Alias definitions
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

######################
# Settings for Linux #
######################

if [[ "$OSTYPE" == "linux-gnu" ]]; then

  # set variable identifying the chroot you work in
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # activate 256 colors support
  export TERM=xterm-256color

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability
  force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi

  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
      ;;
    *)
      ;;
  esac

  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  # enable programmable completion features 
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi

  # Quickly navigate the filesystem using new jump and mark functions.
  # To add a new bookmark, cd into the directory and mark it with a name.
  export MARKPATH=$HOME/.marks
  function jump { 
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
  }
  function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
  }
  function unmark { 
  rm -i "$MARKPATH/$1"
  }
  function marks {
  ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
  }

  # Adds tab completion for jump and unmark functions
  _completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
  }
  complete -F _completemarks jump unmark

fi

#########################
# Settings for Mac OS X #
#########################

if [[ "$OSTYPE" == "darwin"* ]]; then

  # sets up custom prompt
  export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "

  # activates colors
  export CLICOLOR=1

  # ls custom colors
  export LSCOLORS=ExFxBxDxCxegedabagacad

  # activates tab completion for homebrew
  source `brew --repository`/Library/Contributions/brew_bash_completion.sh

  # activates tab completion for git
  source ~/bin/git-completion.bash

  # correctly load tools installed by homebrew
  export PATH=/usr/local/bin:$PATH

  # Jump and mark functions.
  export MARKPATH=$HOME/.marks
  function jump { 
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
  }
  function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
  }
  function unmark { 
    rm -i "$MARKPATH/$1"
  }
  function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
  }

  # Tab completion for jump and unmark functions
  function _jump {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local marks=$(find $MARKPATH -type l | awk -F '/' '{print $NF}')
    COMPREPLY=($(compgen -W '${marks[@]}' -- "$cur"))
    return 0
  }
  complete -o default -o nospace -F _jump jump

fi

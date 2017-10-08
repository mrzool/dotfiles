# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

export EDITOR="vim"

# Implicit cd
shopt -s autocd
# Correct minor errors in the spelling of a directory
shopt -s cdspell
shopt -s dirspell
# Define search path for the cd command
CDPATH=".:~/repos"
# Activate and define cdable variables
shopt -s cdable_vars
export dotfiles="$HOME/dotfiles"
export repos="$HOME/repos"
export dropbox="$HOME/Dropbox"
export jobs="$HOME/Documents/jobs/"
export notes="$HOME/Dropbox/notes/"


# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL="erasedups:ignoreboth"
# Commands that don't need to get recorded
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
# Save multi-line commands to the history as one command
shopt -s cmdhist
# Append to the history file, don't overwrite it
shopt -s histappend
# Set history size to a very large number
HISTSIZE=500000
HISTFILESIZE=100000
# Record each line of history right away
# instead of at the end of the session
PROMPT_COMMAND='history -a'
# Set history timestamp format
HISTTIMEFORMAT='%F %T '

# Take quick notes from the command line
notes() {
  if [ ! -z "$1" ]; then
    # Using the "$@" here will take all parameters passed into
    # this function so we can place everything into our file.
    echo "$@" >> "$notes/memo-cli-oneliners.txt"
  else
    # If no arguments were passed we will take stdin and place
    # it into our notes instead.
    cat - >> "$notes/memo-cli-oneliners.txt"
  fi
}

# Custom prompt, git-aware
export GITAWAREPROMPT=~/bin/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\[\033[33;1m\]\W\[\033[m\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$ "

# Complete all the things
source ~/bin/completions/git-completion.bash
source ~/bin/completions/tmux.completion.bash
source ~/bin/completions/tmuxinator.bash
source ~/bin/completions/npm-completion.bash
source ~/bin/completions/pandoc.bash

# Add node bin folder to PATH
export PATH="$HOME/.node/bin:$PATH"
# Add my bin folder to PATH
export PATH="$HOME/bin:$PATH"

# Allow C-W mapping in inputrc to work
# see https://unix.stackexchange.com/q/296822/63527
stty werase undef

if [[ "$OSTYPE" == "darwin"* ]]; then

  # Set up locales
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  # Enable Bash completion
  if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
    . $(brew --prefix)/share/bash-completion/bash_completion
  fi

  # Activates colors
  export CLICOLOR=1
  # Base16 Shell
  BASE16_SHELL=$HOME/.config/base16-shell/
  [ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"
  # ls custom colors
  export LSCOLORS=ExFxBxDxCxegedabagacad
  # Fix support for 256 colors in tmux
  [ -n "$TMUX" ] && export TERM=screen-256color-italic

  # Add homebrew bin folder to PATH
  export PATH="/usr/local/bin:$PATH"
  # Fix LaTeX after El Capitan update
  export PATH="$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin"
  # Add Calibre command line tools
  export PATH=$PATH:/Applications/calibre.app/Contents/MacOS
  # Add Miniconda2
  export PATH="/Users/zool/tools/miniconda2/bin:$PATH"

  # Archey :)
  archey -o

elif [[ "$OSTYPE" == "linux-gnu" ]]; then

  # Set variable identifying the chroot you work in
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # Set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color) color_prompt=yes;;
  esac

  # Uncomment for a colored prompt, if the terminal has the capability
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

  # Enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  # Enable programmable completion features
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi

fi

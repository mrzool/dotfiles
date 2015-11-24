#########################
# Settings for Mac OS X #
#########################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Alias definitions
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# Add bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL="erasedups:ignoreboth"

# No need to remember the exit command.
export HISTIGNORE="&:[ ]*:exit"

# Save multi-line commands to the history as one command.
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500000
HISTFILESIZE=100000

# Activate and define cdable variables
shopt -s cdable_vars
export df="$HOME/dotfiles"
export repos="$HOME/repos"
export documents="$HOME/Documents"
export mrzool="$HOME/repos/mrzool.github.io"

# Implicit cd
shopt -s autocd

# Correct minor errors in the spelling of a directory when cding
shopt -s cdspell

# sets up custom prompt
export GITAWAREPROMPT=~/bin/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\[\033[33;1m\]\W\[\033[m\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$ "

# activates colors
export CLICOLOR=1

# ls custom colors
export LSCOLORS=ExFxBxDxCxegedabagacad

# Base16 Shell
BASE16_SHELL="/Users/zool/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Completion Settings
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Complete all the things
source `brew --repository`/Library/Contributions/brew_bash_completion.sh
source ~/bin/git-completion.bash
source ~/bin/tmux.completion.bash
source ~/bin/tmuxinator.bash
source ~/bin/npm-completion.bash

# add homebrew bin folder to PATH
export PATH="/usr/local/bin:$PATH"

# add node bin folder to PATH
export PATH="$HOME/.node/bin:$PATH"

# Add my bin folder
export PATH="$HOME/bin:$PATH"

# Fix LaTeX after El Capitan update
export PATH="$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin"

# Set Vim as default editor
export EDITOR="vim"

source ~/.profile

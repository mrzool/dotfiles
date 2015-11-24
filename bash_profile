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

source `brew --repository`/Library/Contributions/brew_bash_completion.sh
source ~/bin/git-completion.bash
source ~/bin/tmux.completion.bash
source ~/bin/tmuxinator.bash

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
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

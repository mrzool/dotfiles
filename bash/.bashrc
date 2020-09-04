# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# Define function to add a directory to $PATH
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

export EDITOR="vim"

# Implicit cd
shopt -s autocd
# Correct minor errors in the spelling of a directory
shopt -s cdspell
shopt -s dirspell

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

# Custom prompt, git-aware
export GITAWAREPROMPT=~/bin/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\[\033[33;1m\]\W\[\033[m\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$ "

# Complete all the things
source ~/bin/completions/git-completion.bash
source ~/bin/completions/tmux.completion.bash
source ~/bin/completions/npm-completion.bash
source ~/bin/completions/pandoc.bash
source ~/bin/completions/beet.bash

# Add bin folder
pathadd $HOME/bin

# Allow C-W mapping in inputrc to work
# see https://unix.stackexchange.com/q/296822/63527
stty werase undef

if [[ "$OSTYPE" == "darwin"* ]]; then
  source ~/.bashrc.macos
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  source ~/.bashrc.linux-gnu

fi

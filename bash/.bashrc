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

  source ~/.bashrc.macos

elif [[ "$OSTYPE" == "linux-gnu" ]]; then

  source ~/.bashrc.linux-gnu

fi

# Interactive shells only
case $- in
    *i*) ;;
      *) return ;;
esac


# Environment and PATH
# --------------------

export EDITOR="vim"
export BAT_THEME="ansi"

# Prepend a directory to PATH if it exists and isn't already present
pathadd() {
    if [[ -d "$1" && ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

pathadd "$HOME/bin"
pathadd "$HOME/.local/bin"
pathadd "$HOME/go/bin"

# Rust
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Platform-specific configuration
# -------------------------------

if [[ "$OSTYPE" == darwin* ]]; then
    [[ -r "$HOME/.bashrc.macos" ]] && source "$HOME/.bashrc.macos"
elif [[ "$OSTYPE" == linux-gnu* ]]; then
    [[ -r "$HOME/.bashrc.linux-gnu" ]] && source "$HOME/.bashrc.linux-gnu"
fi

# Shell options
# -------------

shopt -s autocd      # Implicit cd
shopt -s cdspell     # Correct minor directory spelling errors
shopt -s dirspell    # Correct spelling errors during completion
shopt -s globstar    # Recursive globbing


# History
# -------

HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

shopt -s cmdhist
shopt -s histappend

HISTSIZE=500000
HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T '

# Write history after each command
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"


# Prompt
# ------

export GITAWAREPROMPT="$HOME/bin/git-aware-prompt"

if [[ -r "$GITAWAREPROMPT/main.sh" ]]; then
    source "$GITAWAREPROMPT/main.sh"
    export PS1="\[\033[33;1m\]\W\[\033[m\]\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$ "
fi


# Completions
# -----------

[[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]] && . /opt/homebrew/etc/profile.d/bash_completion.sh

for file in "$HOME"/bin/completions/*.bash; do
    [[ -r "$file" ]] && source "$file"
done

unset file


# Functions
# ---------

# Simple calculator
calc() {
    local result=""
    result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"

    if [[ "$result" == *.* ]]; then
        printf '%s' "$result" |
            sed -e 's/^\./0./' \
                -e 's/^-\./-0./' \
                -e 's/0*$//;s/\.$//'
    else
        printf '%s' "$result"
    fi

    printf '\n'
}

# Disable Ctrl-W's terminal handling (configured in inputrc)
stty werase undef


# Optional integrations
# ---------------------

[[ -r "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash"
[[ -r "$HOME/.aliases" ]] && source "$HOME/.aliases"
[[ -r "$HOME/.beets" ]] && source "$HOME/.beets"

#!/usr/bin/env bash
[[ $- != *i* ]] && return

export XDG_CONFIG_HOME="$HOME/.config"
export TERMINAL=kitty
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
export HISTCONTROL=ignoreboth:erasedups # ignore duplicates
export MANPAGER="nvim +Man!"
export HISTSIZE=2000
export HISTSIZEFILE=2000

if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ]; then
    PATH="$HOME/Applications:$PATH"
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

source "$HOME/.bash_aliases"

eval "$(starship init bash)"
eval "$(aactivator.py init)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# --- setup fzf theme ---
fg="#cad3f5"
bg="#24273a"
bg_highlight="#363a4f"
purple="#c6a0f6"
blue="#8aadf4"
cyan="#8bd5ca"

preview_file() {
    if [ -d "$1" ]; then
        eza --tree --color=always "$1" | head -200
    elif [ -f "$1" ]; then
        bat -n --color=always --line-range :500 "$1"
    else
        echo "$1 is not a file or directory"
    fi
}

export -f preview_file

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan} --preview 'preview_file {}'"
# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

# source ~/fzf-git.sh/fzf-git.sh

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
    cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    # ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
    esac
}

# pomodoro {time}[h/m] {notification_title} {notification_body}
pomodoro() {
    work_period=$1
    notification_title=$3
    notification_body=$4

    case $2 in
    *"m")
        x="${2%m}"
        break_secods=$((x * 60))
        ;;
    *"h")
        x="${2%h}"
        break_secods=$((x * 60 * 60))
        ;;
    *)
        break_secods=$2
        ;;
    esac

    update_interval=$(awk "BEGIN {printf \"%.2f\" , $break_secods / 100.0}")

    while true; do
        break_tmp=$break_secods
        i=100

        sleep "$work_period"

        while [ "$i" -gt 0 ]; do
            # Compute remaining minutes and strip numbers after . so 1.23 min -> 1 min
            remaining_min=$(awk "BEGIN {printf \"%.2f\" , $break_tmp / 60}")
            remaining_min="${remaining_min%.*}"

            # Compute remaining seconds and strip numbers after . so 1.23 s -> 1 s
            remaining_sec=$(awk "BEGIN {printf \"%.2f\" , $break_tmp % 60}")
            remaining_sec="${remaining_sec%.*}"

            dunstify "$notification_title" "$notification_body przez $((break_secods / 60)) min\n\nPozostało: $remaining_min min $remaining_sec s" -r 892377 -h int:value:"$i" -i /usr/share/icons/Yaru/32x32/apps/clock-app.png
            ((i--))
            break_tmp=$(awk "BEGIN {printf \"%.2f\" , $break_tmp - $update_interval }")
            sleep "$update_interval"
        done
    done
}

eval "$(zoxide init bash --cmd cd)"

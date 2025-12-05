eval "$(starship init -- zsh)"

# Load Homebrew-installed zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Load Homebrew-installed zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source <(fzf --zsh)

# Customize zsh-syntax-highlighting colors
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue,bold'

# Command to open the GitHub repository in the default web browser
opengh() {
    local url
    url=$(git config --get remote.origin.url)
    if [ -z "$url" ]; then
        echo "Error: No remote 'origin' repository found."
        return 1
    fi
    local web_url
    web_url=$(echo "$url" | sed -e 's|git@github.com:|https://github.com/|' -e 's|\.git$||')
    echo "Opening $web_url ..."
    open "$web_url"
}

tree() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        local depth="$1"
        shift
        lsd --tree --depth "$depth" "$@"
    else
        lsd --tree --depth 2 "$@"
    fi
}

export MANPAGER='nvim +Man!'

alias ls=lsd

# swag points
fastfetch  

# Auto-attach to a tmux session or create a new one
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi


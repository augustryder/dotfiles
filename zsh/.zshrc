eval "$(starship init zsh)"

# Load Homebrew-installed zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Load Homebrew-installed zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source <(fzf --zsh)

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
    if [ -z "$1" ]; then
        lsd --tree --depth 2
        return
    fi
    lsd --tree --depth "$1"
}

alias ls=lsd

fastfetch

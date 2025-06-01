eval "$(starship init zsh)"

# Load Homebrew-installed zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Load Homebrew-installed zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source <(fzf --zsh)

# Command to open the GitHub repository in the default web browser
opengh() {
    local url
    url=$(git config --get remote.origin.url | sed 's/git@github.com/https:\/\/github.com\//' | sed 's/\.git//')
    if [ -n "$url" ]; then
        open "$url"
    else
        echo "No remote repository found."
    fi
}

alias ls=lsd

fastfetch

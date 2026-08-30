# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# theme
ZSH_THEME="spiderverse"

# disable auto updates
zstyle ':omz:update' mode disabled

# plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# bun completions
[ -s "/home/shaaanuu/.bun/_bun" ] && source "/home/shaaanuu/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

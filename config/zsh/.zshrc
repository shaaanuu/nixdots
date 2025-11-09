# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# theme
ZSH_THEME="spiderverse"

# disable auto updates
zstyle ':omz:update' mode disabled

# plugins
plugins=(git)

# flutter
export PATH="$PATH:$HOME/dev/flutter/bin"

# flutter, but for android
export ANDROID=$HOME/dev/android
export PATH=$ANDROID/latest/cmdline-tools:$PATH
export PATH=$ANDROID/latest/cmdline-tools/bin:$PATH
export PATH=$ANDROID/platform-tools:$PATH
# Android SDK
export ANDROID_SDK_ROOT=$HOME/dev/android
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH

source $ZSH/oh-my-zsh.sh

# bun completions
[ -s "/home/shaaanuu/.bun/_bun" ] && source "/home/shaaanuu/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

###
# Environments
###
# You may need to manually set your language environment
set -gxU LANG 'en_US.UTF-8'

# Proxy brew source with tsinghua.
# Doc: https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
set -gxU HOMEBREW_API_DOMAIN 'https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api'
set -gxU HOMEBREW_BOTTLE_DOMAIN 'https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles'
set -gxU HOMEBREW_BREW_GIT_REMOTE 'https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git'

# Set theme for bat syntax highlighting.
# Or just call bat with the --theme=DarkNeon option
set -gxU BAT_THEME 'DarkNeon'

# Set fzf layout: https://github.com/junegunn/fzf#layout
set -gxU FZF_DEFAULT_OPTS '--height 40% --layout=reverse --info=inline --border --preview="bat --color=always --style=numbers --line-range=:100 {}" --preview-window="right:60%" --bind "up:preview-up,down:preview-down"'
set -gxU FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Bun
set -gxU BUN_INSTALL "$HOME/.bun"
set -gxU PATH $BUN_INSTALL/bin $PATH

# Setup go path
set -gxU GOPATH "$HOME/.go"

###
# alias
###
alias vim='/usr/local/bin/nvim'

# Quick start or close proxy
alias pon='set -gx http_proxy http://proxy.internal:7890 && set -gx https_proxy $http_proxy && set -gx all_proxy $http_proxy'
alias poff='set -e http_proxy && set -e https_proxy && set -e all_proxy'
alias proxy='set -gx http_proxy http://proxy.internal:7890 && set -gx https_proxy $http_proxy && set -gx all_proxy $http_proxy'
alias unproxy='set -e http_proxy && set -e https_proxy && set -e all_proxy'

# Use git likes a pro
# Synchronize the latest remote changes to the local.
abbr -a -- gsync 'git fetch --prune && git pull && git delete-squashed-branches && git delete-merged-branches'

# Format changed only
abbr -a -- pretty 'prettier -w $(git diff --name-only --diff-filter=AM)'

fish_add_path /Users/sqrtthree/.cargo/bin

starship init fish | source
zoxide init fish | source

# Set up fzf key bindings
fzf --fish | source

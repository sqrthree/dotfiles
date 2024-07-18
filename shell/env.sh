export PATH="$HOME/bin:/opt/homebrew/bin:/usr/local/sbin:$PATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# https://github.com/pstadler/keybase-gpg-github#optional-setting-up-tty
GPG_TTY=$(tty)
export GPG_TTY

# Proxy brew source with tsinghua.
# Doc: https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"

# Set theme for bat syntax highlighting.
# Or just call bat with the --theme=DarkNeon option
export BAT_THEME="DarkNeon"

# Set fzf layout: https://github.com/junegunn/fzf#layout
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --info=inline --border --preview="bat --color=always --style=numbers --line-range=:100 {}" --preview-window="right:60%" --bind up:preview-up,down:preview-down'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude .git --exclude dist'

# Setup go path
export GOPATH="$HOME/.go"

alias vim='/usr/local/bin/nvim' # Replace vim by neovim

alias ls='ls -G'             # Enable colorized output by default
alias la="ls -G --all"       # Create `la` as a shortcut for `ls --all`
alias diff='colordiff -i -y' # colorize diff output.

# Get ip as soon as possible.
alias ip="ipconfig getifaddr en0"            # Get the local IP address
alias getip="curl -s https://httpbin.org/ip" # Get the external IP address

# Use git like a pro.
alias git_top="git log --pretty='%aN' | sort | uniq -c | sort -k1 -n -r"
alias git_top5="git log --pretty='%aN' | sort | uniq -c | sort -k1 -n -r | head -n 5"

# Quick start or close proxy
alias pon='export http_proxy=http://proxy.internal:7890;export https_proxy=$http_proxy; export all_proxy=$http_proxy;'
alias poff='unset http_proxy;unset https_proxy; unset all_proxy;'
alias proxy='export http_proxy=http://proxy.internal:7890;export https_proxy=$http_proxy; export all_proxy=$http_proxy;'
alias unproxy='unset http_proxy;unset https_proxy; unset all_proxy;'

###
# Print an info-level message.
###
info() {
	printf "\r[ \033[00;34m..\033[0m ] $1\n"
}

###
# Print a warning-level message.
###
warn() {
	printf "\r[ \033[0;33m??\033[0m ] $1\n"
}

###
# Print a success-level message.
###
success() {
	printf "\r\033[2K[ \033[00;32mOK\033[0m ] $1\n"
}

###
# Print a fail-level message and exit the process by 1.
###
fail() {
	printf "\r\033[2K[\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit 1
}

###
# Ask Y/n
#
# @params $1 The prompt message.
# @returns {Boolean}
#
# @example
#  if ask "already exists, overwrite?"; then
#    echo "something"
#  fi
#
###
ask() {
	read -p "$1 (Y/n): " resp
	if [ -z "$resp" ]; then
		response_lc="y" # empty is Yes
	else
		response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
	fi

	[ "$response_lc" = "y" ]
}

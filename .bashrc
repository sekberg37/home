force_color_prompt=yes

# Set emacs editing mode
set -o emacs

# Source environment variables
. ~/.environs

# Source aliases
. ~/.bash_aliases

## Path
add_path_to_dir() {
    dir="$1"
    search="${2:-$1}"

    [ -d "$dir" ] && $(echo ":$PATH:" | grep -E "$search" > /dev/null) || PATH="$PATH:$dir"
    return $?
}

add_path_to_dir "~/bin" ":~/bin:|:$HOME/bin:"
# Setting PATH for Python 3.6
pypath="/Library/Framework/Python.framework/Versions/3.6/bin"
add_path_to_dir "$pypath"

localpypath="$HOME/Library/Python/3.6/bin"
add_path_to_dir "$localpypath"

export PATH

## Platform specifics
if [ ${MSYSTEM-x} != x ]; then
    if [ ! -f ~/bin/vsvars.sh ]; then
        echo "Generating vsvars.sh"
        . ~/bin/generate_vsvars
    fi

    . ~/bin/vsvars.sh

    export SSH_AUTH_SOCK=/tmp/keepass.sock
else
    if [ -d ~/.dircolors ]; then eval `dircolors ~/.dircolors/dircolors.256dark`; fi;

    . ~/.git-completion
    . ~/.git-prompt

    export PS1="\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[0m\]\n\$ "
fi;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

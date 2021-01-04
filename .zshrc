# exports
export SETUP_DIR=$HOME/.setup
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='nvim'
export HOMEBREW_BUNDLE_FILE=$SETUP_DIR/Brewfile


export CARDS_DIR=~/projects/notes
export PATH=$CARDS_DIR/bin:$HOME/.bin:$PATH

# aliases: misc
alias e="${EDITOR}" # open editor
alias h="http"
alias c='pygmentize -O style=monokai -f console256 -g' # print a file  with syntax highlighting
alias x='exa'

function dict () {
        if [[ $1 == (d|m) ]]; then
                curl dict://dict.org/$1:$2 | $PAGER
        else
            echo 'Unknown command. Use (d)efine or (m)atch.'
        fi
    }

# dot files 
alias -g gitdf='git --git-dir=$HOME/projects/dotfiles.git --work-tree=$HOME'
gitdf config status.showUntrackedFiles no

# aliases: zsh
alias dot!='${SETUP_DIR}/install.sh' # Reinstall dotfiles
alias esc="e ~/.ssh/config" 

# aliases: docker
alias dk='docker'
alias dc='docker-compose'
alias de='docker exec -it'

# aliases: misc
alias cpk='cat ~/.ssh/id_rsa.pub | pbcopy; echo "Public key copied to clipboard"' # Copy my public SSH key to clipboard
alias grepr='grep -R . -e ' # grep recursively
alias eeh="sudo vim /etc/hosts" # quickly edit /etc/hosts





# antigen:setup
source "$SETUP_DIR"/antigen.zsh
antigen use oh-my-zsh # Load the oh-my-zsh's library.

# antigen:theme
antigen theme robbyrussell # theme

# antigen:tools
antigen bundle git  # Git command-line autocompletions
antigen bundle docker  # Auto-completion for the docker command
antigen bundle zsh-users/zsh-syntax-highlighting  # Syntax highlighting
antigen bundle djui/alias-tips # Show tips of a command can be shortened with an alias
antigen bundle autojump # Automagically jump between directories
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# antigen:end
antigen apply # Tell Antigen we are done


# antigen:history search with just UP/DOWN arrows, similar to Fish
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1


# zsh:misc config
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
COMPLETION_WAITING_DOTS="true"  # Display red dots whilst waiting for completion.

# Perform ls after each dir-change
# http://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    exa 
}

source ~/.fzf-aliases.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
	nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

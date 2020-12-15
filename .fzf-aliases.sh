# autojump
# like normal autojump when used with arguments but displays an fzf prompt when used without 
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)" 
}

# select which npm script to run
npmrf() {
  local script
  script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
}

# dotfiles
edf() {
  local dotfile
  dotfile=$(gitdf ls-tree --name-only --full-name master $HOME | sort | fzf) && $EDITOR $HOME/"$dotfile"
}

faq() {
  local faq
  cd ~/projects/dev-handbook
  faq=$(grep -r --include="*.md" '^# ' . | fzf | cut -f1 -d: ) && glow $faq
}

# starship
eval "$(starship init zsh)"
# zoxide 
eval "$(zoxide init zsh)"

# fzf (ファジー検索) の設定
# fzfのキーバインドと自動補完を有効化
source <(fzf --zsh)

# 4. ghq + fzf の連携機能
# Ctrl + g でリポジトリを検索して移動する設定
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+2 | head -n 20")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# alias
alias ls='eza --icons --git'
alias ll='ls -l'
alias la='ls -la'
alias lg='lazygit'
alias grep='rg'
alias y='yazi'

# Added by Antigravity
export PATH="/Users/manabu/.antigravity/antigravity/bin:$PATH"

# yaziから利用するエディタ
export EDITOR="hx"

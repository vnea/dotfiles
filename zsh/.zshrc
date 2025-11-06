# Performance optimizations (source: https://scottspence.com/posts/speeding-up-my-zsh-shell)
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

##############################
# p10k
##############################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$HOME/.cache/p10k-instant-prompt-$USER.zsh" ]]; then
  source "$HOME/.cache/p10k-instant-prompt-$USER.zsh"
fi

source ~/.p10k.zsh

if [[ "$(uname)" == "Darwin" ]]; then
  source "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"
else
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

##############################
# Oh My Zsh
##############################
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  colored-man-pages
  wd
  zsh-syntax-highlighting # Must be the last
)

# Add zsh-completions
fpath=(~/dotfiles/zsh/zsh-completions $fpath)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.zshenv  ]] && source ~/.zshenv

# Autosuggest settings for performance (source: https://scottspence.com/posts/speeding-up-my-zsh-shell)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

##############################
# General
##############################
export PROMPT="${PROMPT}"$'\n'""
export EDITOR=nvim
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:${KREW_ROOT:-$HOME/.krew}/bin"

##############################
# History
##############################
HISTFILE=$HOME/.zsh_history
HISTDUP=erase
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
# To ignore a command from being added to the history, prefix it with a space, source: https://unix.stackexchange.com/questions/6094/is-there-any-way-to-keep-a-command-from-being-added-to-your-history
setopt HIST_IGNORE_SPACE

##############################
# Load aliases
##############################
for f in $(find ~/dotfiles/aliases -maxdepth 1 -name "*.sh"); do source $f; done

##############################
# tmux plugin conf
##############################
export DISABLE_AUTO_TITLE="true"

##############################
# Bindings
##############################
bindkey "^O" edit-command-line

##############################
# FZF
##############################
source <(fzf --zsh)

export FZF_DEFAULT_OPTS="
  --multi
  --height 100%
  --color=fg:#828282,fg+:#d0d0d0,bg:#0d1116,bg+:#262626
  --color=hl:#037d29,hl+:#60D701,info:#afaf87,marker:#87ff00
  --color=prompt:#60D701,spinner:#af5fff,pointer:#60D701,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
"

export FZF_CTRL_T_COMMAND="fd --hidden --exclude={.git/,node_modules/,.venv/}"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :100 {}'"

##############################
# The Fuck
##############################
eval $(thefuck --alias)

##############################
# Mise
##############################
eval "$($(brew --prefix)/bin/mise activate zsh)"

##############################
# Virtualenvwrapper (workon)
##############################
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
# export WORKON_HOME=$HOME/python/virtualenvs
# source /usr/bin/virtualenvwrapper.sh

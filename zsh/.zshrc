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
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

##############################
# Oh My Zsh
##############################
export ZSH="$HOME/.oh-my-zsh"
plugins=(
  colored-man-pages
  dirhistory
  git
  history
  kubectl
  wd
  yarn
  zsh-syntax-highlighting # Must be the last
)
source $ZSH/oh-my-zsh.sh

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
# Flux
##############################
command -v flux >/dev/null && . <(flux completion zsh)

##############################
# tmux plugin conf
##############################
export DISABLE_AUTO_TITLE="true"

##############################
# asdf
##############################
source /opt/asdf-vm/asdf.sh

##############################
# FZF
##############################
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

##############################
# The Fuck
##############################
eval $(thefuck --alias)

##############################
# direnv
##############################
# To disable direnv logs
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

##############################
# Virtualenvwrapper (workon)
##############################
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export WORKON_HOME=$HOME/python/virtualenvs
source /usr/bin/virtualenvwrapper.sh

##############################
# Chrome
##############################
export CHROMIUM_USER_FLAGS=""

# Toggle bg/fg with CTRL+Z, source: https://unix.stackexchange.com/a/179373
# _zsh_cli_fg() { fg; }
# zle -N _zsh_cli_fg
# bindkey '^Z' _zsh_cli_fg

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################
# Oh My Zsh
##############################
export ZSH="/home/$USER/.oh-my-zsh"
plugins=(
  colored-man-pages
  git
  history
  kubectl
  wd
  yarn
  dirhistory
  zsh-syntax-highlighting # Must be the last
)
source $ZSH/oh-my-zsh.sh

##############################
# General
##############################
export PROMPT="${PROMPT}"$'\n'""
export EDITOR=nvim

##############################
# Load aliases
##############################
for f in $(find ~/dotfiles/aliases -maxdepth 1 -name "*.sh"); do source $f; done

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
# Path
##############################
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:/home/$USER/.asdf/installs/golang/1.20.4/packages/bin"

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

##############################
# Chrome
##############################
export CHROMIUM_USER_FLAGS=""

##############################
# History
##############################
# To ignore a command from being added to the history, prefix it with a space, source: https://unix.stackexchange.com/questions/6094/is-there-any-way-to-keep-a-command-from-being-added-to-your-history
setopt HIST_IGNORE_SPACE

##############################
# p10k
##############################
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
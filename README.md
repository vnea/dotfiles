# Dotfiles

## 0. Getting started

### Prerequisite

* [git](https://git-scm.com/)
* [GNU stow](https://www.gnu.org/software/stow/)

### Installation

```shell
# Via SSH
git clone git@github.com:vnea/bootsrap-poste.git ~

# Or via HTTP
git clone https://github.com/vnea/bootsrap-poste.git ~
```

## 1. Neovim

### Prerequisite

* [Neovim](https://neovim.io/) >= v0.5
* [packer.nvim](https://github.com/wbthomason/packer.nvim)

### Installation

```shell
rm -rf ~/.config/nvim
ln -s ~/bootsrap-poste/nvim ~/.config/nvim
```

## 2. tmux

### Prerequisite

* [tmux](https://github.com/tmux/tmux) >= v3.2

### Installation

Create symbolic link:

```shell
rm -rf ~/.tmux.conf ~/config/tmux && stow tmux
```

Install tmux plugins:

```shell
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux
# Press "CTRL-Q then I", wait for installation and restart tmux
```

## 3. Git

### Prerequisite

* [git](https://git-scm.com/)
* [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
* (optional) ansible-vault-merge:
    * Download [here](https://raw.githubusercontent.com/building5/ansible-vault-tools/master/ansible-vault-merge.sh)
      with name `ansible-vault-merge`
    * ```chmod +x ansible-vault-merge```
    * ```sudo mv ansible-vault-merge /usr/local/bin```

### Installation

```shell
rm -f ~/.gitconfig
git config --global user.name "User name"
git config --global user.email "email"

cat <<EOT >> ~/.gitconfig

[include]
    path = bootsrap-poste/git/.gitconfig

EOT
```

## 4. i3

### Prerequisite

* [i3wm](https://i3wm.org/)
* [i3lock-fancy-rapid](https://github.com/yvbbrjdr/i3lock-fancy-rapid): build it locally
  in `~/bootsrap-poste/i3/build/i3lock-fancy-rapid`
* [polybar](https://github.com/polybar/polybar): build it locally in `~/bootsrap-poste/i3/build/polybar`

### Installation

Create symbolic link:

```shell
rm -rf ~/.config/i3 && stow i3
```

## 5. rofi

### Prerequisite

* [rofi](https://github.com/davatorium/rofi)

### Installation

Create symbolic link:

```shell
rm -rf ~/.config/rofi && stow rofi
```

# Dotfiles

Just my dotfiles.

## 0. Getting started

### Prerequisite(s)

* [git](https://git-scm.com)
* [GNU stow](https://www.gnu.org/software/stow)

### Installation

```shell
# Via SSH
git clone git@github.com:vnea/dotfiles.git ~/dotfiles

# Or via HTTP
git clone https://github.com/vnea/dotfiles.git ~/dotfiles
```

## 1. Neovim

### Prerequisite(s)

* [Neovim](https://neovim.io) >= v0.5
* [packer.nvim](https://github.com/wbthomason/packer.nvim)

### Installation

```shell
rm -rf ~/.config/nvim
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## 2. tmux

### Prerequisite(s)

* [tmux](https://github.com/tmux/tmux) >= v3.2

### Installation

```shell
# tmux
rm -rf ~/.tmux.conf ~/.config/tmux && stow tmux

# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux
# Press "CTRL-Q then I", wait for installation and restart tmux
```

## 3. Git

### Prerequisite(s)

* [git](https://git-scm.com)
* [delta](https://github.com/dandavison/delta)
* [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
* (optional) ansible-vault-merge:
    * Download [here](https://raw.githubusercontent.com/building5/ansible-vault-tools/master/ansible-vault-merge.sh)
      with name `ansible-vault-merge`
    * (Check that script is not malicious before continuing) 
    * ```chmod +x ansible-vault-merge```
    * ```sudo mv ansible-vault-merge /usr/local/bin```

### Installation

```shell
rm -f ~/.gitconfig
git config --global user.name "User name"
git config --global user.email "email"

cat <<EOT >> ~/.gitconfig

[include]
    path = dotfiles/git/.gitconfig

EOT
```

## 4. i3

### Prerequisite(s)

* [i3wm](https://i3wm.org)
* [Betterlockscreen](check section `10. Betterlockscreen`)
* [Polybar](https://github.com/polybar/polybar)
* [ttf-noto-nerd](https://archlinux.org/packages/community/any/ttf-noto-nerd)
* [Dunst](https://github.com/dunst-project/dunst) (for Pomodoro Polybar text notification, see section `8. Dunst`)
* [Papirus icon them](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
* [Sox](https://sox.sourceforge.net/) (for Pomodoro Polybar sound notification)
* [feh](https://feh.finalrewind.org)
* [Picom](https://github.com/yshui/picom)
* [Light](https://github.com/haikarainen/light)

### Installation

```shell
# i3
rm -rf ~/.config/i3 && stow i3

# picom
rm -rf ~/.config/picom && stow picom

# light
sudo gpasswd -a $USER video
# Reboot computer
```

## 5. rofi

### Prerequisite(s)

* [rofi](https://github.com/davatorium/rofi)
* [rofi-themes](https://github.com/adi1090x/rofi)

### Installation

```shell
rm -rf ~/.config/rofi/config.rasi && stow rofi
```

## 6. thefuck

### Installation

```shell
rm -rf ~/.config/thefuck && stow thefuck
```

## 7. GTK

### Installation

```shell
rm -rf ~/.config/gtk-3.0 && stow gtk
```

## 8. Dunst

### Installation

```shell
rm -rf ~/.config/dunst && stow dunst
```

## 9. Powerlevel10k

### Installation

```shell
rm -f ~/.p10k.zsh && stow p10k

# Reboot the Terminal
```

## 10. Betterlockscreen

Link: https://github.com/betterlockscreen/betterlockscreen

### Prerequisite(s)

* [i3lock-color](https://github.com/Raymo111/i3lock-color)

### Generate cache

```shell
betterlockscreen --update ~/.config/i3/images/lockscreen.jpg --fx blur
```

### Lockscreen after sleep/suspend

```shell
systemctl enable betterlockscreen@$USER
```

## 11. Terminator

Link: https://wiki.archlinux.org/title/Terminator

### Installation

```shell
rm -rf ~/.config/terminator && stow terminator
```

## 12. Flameshot

Link: https://flameshot.org/

### Installation

```shell
rm -rf ~/.config/flameshot && stow flameshot
```

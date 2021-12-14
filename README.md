# dotfiles

# Clone the project in home directory

```shell
# Via SSH
git clone git@github.com:vnea/bootsrap-poste.git ~

# Or via HTTP
git clone https://github.com/vnea/bootsrap-poste.git ~
```

# Neovim

```shell
rm -rf ~/.config/nvim
ln -s ~/bootsrap-poste/nvim ~/.config/nvim
```

# tmux

```shell
ln -s ~/bootsrap-poste/tmux/.tmux.conf ~/.tmux.conf
```

# Git

```shell
git config --global user.name "User name"
git config --global user.email "email"

cat <<EOT >> ~/.gitconfig

[include]
    path = bootsrap-poste/git/.gitconfig

EOT
```

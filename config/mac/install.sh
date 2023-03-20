
# Zsh
ln -sf ~/AshSwing/config/mac/shrc/zshrc ~/.zshrc

# Kitty
rm -rf ~/.config/kitty
ln -sfn ~/AshSwing/config/mac/kitty ~/.config/kitty

# Starship
ln -sf ~/AshSwing/config/mac/starship.toml ~/.config/starship.toml

# NeoVim
rm -rf ~/.config/nvim/lua/user
ln -sfn ~/AshSwing/config/mac/nvim ~/.config/nvim/lua/user

# Conda
ln -sf ~/AshSwing/config/mac/condarc ~/.condarc


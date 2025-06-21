#!/bin/bash

# Install zsh
sudo apt install zsh

#Install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Copy configuration
cp .p10k.zsh $HOME/.p10k.zsh
cp .zshrc $HOME/.zshrc

#Make zsh terminal default
chsh -s $(which zsh)

echo "Installation complete, please reboot or close the session"

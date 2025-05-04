#!/bin/bash

# Exit on error
set -e

# Function to print messages
log() {
    echo -e "\e[32m$1\e[0m"
}

# Check for argument and set default if none provided
MAKE_DEFAULT_SHELL="${1:-no}"

# Display the selected option
log "Make Zsh default shell: $MAKE_DEFAULT_SHELL"

# Install Zsh
log "Installing Zsh..."
sudo apt update
sudo apt install -y zsh curl git fzf 

# Install Oh My Zsh if not already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    log "Oh My Zsh is already installed at $HOME/.oh-my-zsh. Skipping installation."
else
    log "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

log "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Install Zsh autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    log "Installing Zsh autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    log "Zsh autosuggestions already installed. Skipping."
fi

# Install Zsh syntax highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    log "Installing Zsh syntax highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    log "Zsh syntax highlighting already installed. Skipping."
fi


# Install Zsh syntax highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]; then
    log "Installing Zsh fast syntax highlighting..."
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
else
    log "Zsh syntax highlighting already installed. Skipping."
fi

# Install Zsh syntax highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/colorize" ]; then
    log "Installing Zsh colorize highlighting..."
    git clone https://github.com/zpm-zsh/colorize.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/colorize
else
    log "Zsh colorize already installed. Skipping."
fi

# Install Zsh syntax highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/colorize" ]; then
    log "Installing Zsh colorize highlighting..."
    git clone https://github.com/zpm-zsh/colorize.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/colorize
else
    log "Zsh colorize already installed. Skipping."
fi


# Install Zsh syntax highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search" ]; then
    log "Installing Zsh powerlevel10k..."
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
else
    log "Zsh zsh-history-substring-search already installed. Skipping."
fi


# Update .zshrc to enable plugins
log "Configuring Zsh plugins in .zshrc..."
if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting history zsh-interactive-cd colorize fzf zsh-history-substring-search)/' ~/.zshrc
    log "Updated plugins in .zshrc."
else
    log "Plugins already configured in .zshrc."
fi

# Install Zsh Powerlevel10K
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    log "Installing Zsh powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i 's/robbyrussell/powerlevel10k\/powerlevel10k/' ~/.zshrc
else
    log "Zsh powerlevel10k already installed. Skipping."
fi

 
# Apply changes
log "Applying changes..."
zsh -c "source ~/.zshrc"
pipx ensurepath
log "Oh My Zsh installation completed with autosuggestions and syntax highlighting enabled!"

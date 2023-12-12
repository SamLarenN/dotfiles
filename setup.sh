#!/usr/bin/env bash

if [[ "$(uname)" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y zsh ripgrep build-essential unzip python3-venv zoxide fzf
elif [[ "$(uname)" == "Darwin" ]]; then
    brew install zsh ripgrep zoxide fzf
fi

# Install Lazygit
if ! command -v lazygit 2>&1 >/dev/null; then
  if [[ "$(uname)" == "Linux" ]]; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
    rm lazygit
    rm lazygit.tar.gz
  elif [[ "$(uname)" == "Darwin" ]]; then
    brew install lazygit
  fi
else
  echo "Lazygit is already installed."
fi

# Install Neovim
if ! command -v nvim 2>&1 >/dev/null; then
  if [[ "$(uname)" == "Linux" ]]; then
      sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
      sudo rm -rf /opt/nvim
      sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
      sudo rm nvim-linux-x86_64.tar.gz
  elif [[ "$(uname)" == "Darwin" ]]; then
      brew install neovim
  fi
else
  echo "Neovim is already installed."
fi

# Install Golang
if ! command -v go 2>&1 >/dev/null
then
if [[ "$(uname)" == "Linux" ]]; then
    GO_VERSION="1.24.0"
    curl -LO https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
    tar xvfz go$GO_VERSION.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo mv go /usr/local/
    rm go$GO_VERSION.linux-amd64.tar.gz
elif [[ "$(uname)" == "Darwin" ]]; then
  echo "Golang is not configured to be installed on Mac yet."
fi
else
  echo "Neovim is already installed."
fi

# Install k9s
if ! command -v k9s 2>&1 >/dev/null
then
if [[ "$(uname)" == "Linux" ]]; then
    K9S_VERSION="0.40.1"
    curl -LO https://github.com/derailed/k9s/releases/download/v$K9S_VERSION/k9s_Linux_amd64.tar.gz
    mkdir k9s
    tar xvfz k9s_Linux_amd64.tar.gz -C ./k9s
    rm k9s_Linux_amd64.tar.gz
    sudo mv k9s/k9s /usr/local/bin/
    rm -rf k9s
elif [[ "$(uname)" == "Darwin" ]]; then
    brew install derailed/k9s/k9s
fi
else
  echo "k9s is already installed."
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

# Install p10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  sudo git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
else
  echo "p10k already exists."
fi

# Install fzf-history-search
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-fzf-history-search" ]; then
  sudo git clone https://github.com/joshskidmore/zsh-fzf-history-search $ZSH_CUSTOM/plugins/zsh-fzf-history-search
else
  echo "fzf-history-search already exists."
fi


#ln -sf ~/.dotfiles/wezterm ~/.config/wezterm
ln -sf ~/.dotfiles/nvim ~/.config/nvim
ln -sf ~/.dotfiles/.zshrc ~/.zshrc

#source ~./zshrc

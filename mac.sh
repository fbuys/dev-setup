#!/usr/bin/env bash

if [[ ! -d "$HOME/.bin/" ]]; then
  mkdir "$HOME/.bin"
fi

if [[ ! -d "$HOME/.config/" ]]; then
  mkdir "$HOME/.config"
fi

if [ ! -f "$HOME/.bashrc" ]; then
  touch $HOME/.bashrc
fi

if [[ `uname -m` == 'arm64' ]]; then
  softwareupdate --install-rosetta
fi

println() {
  printf "%b\n" "$1"
}

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      brew upgrade "$@"
      println "Upgraded $1"
    else
      println "$1 already installed"
    fi
  else
    brew install "$@"
  fi
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_is_installed() {
  local NAME=$(brew_expand_alias "$1")

  brew list -1 | grep -Fqx "$NAME"
}

brew_is_upgradable() {
  local NAME=$(brew_expand_alias "$1")

  local INSTALLED=$(brew ls --versions "$NAME" | awk '{print $NF}')
  local LATEST=$(brew info "$NAME" 2>/dev/null | head -1 | awk '{gsub(/,/, ""); print $3}')

  [ "$INSTALLED" != "$LATEST" ]
}

if ! command -v brew &>/dev/null; then
  println "The missing package manager for OS X"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  if ! grep -qs "recommended by brew doctor" ~/.bashrc; then
    println "Put Homebrew location earlier in PATH..."
      printf '\n# recommended by brew doctor\n' >> ~/.bashrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.bashrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
  println "Homebrew already installed. Skipping..."
fi

# Start of installation...

# Symlink dotfiles
dir=./dotfiles
home_files=".vimrc .tmux.conf .zshrc .default-npm-packages"
config_files="karabiner.edn"

if [[ -d $dir ]]
then
  cd $dir
  for file in $home_files; do
    if [[ -f $file ]]
    then
      echo "Creating symlink to $file in home directory."
      ln -sf $(pwd)/$file ~/$file
    fi
  done

  for file in $config_files; do
    if [[ -f $file ]]
    then
      echo "Creating symlink to $file in home/.config directory."
      ln -sf $(pwd)/$file ~/.config/$file
    fi
  done
fi

# Brew
println "Updating Homebrew formulas..."
brew update

println "Installing Git..."
brew_install_or_upgrade 'git'

println "Installing CoreUtiles (asdf dependency)..."
brew_install_or_upgrade 'coreutils'

println "Installing curl (asdf dependency)..."
brew_install_or_upgrade 'curl'

println "Installing gpg (node dependency)..."
brew install gpg

println "Installing gawk (node dependency)..."
brew install gawk

println "Installing iTerm2..."
brew install --cask iterm2
println "Installing Tmux..."
brew install tmux

println "Installing Chrome..."
brew reinstall --cask google-chrome

println "Installing Firefox..."
brew reinstall --cask firefox

println "Installing Slack..."
brew reinstall --cask slack

println "Installing Postgres..."
brew_install_or_upgrade 'postgres'

println "Installing Postgres.app..."
brew reinstall --cask postgres

println "Installing Redis..."
brew_install_or_upgrade 'redis'
println "Installing Karabiner elements..."
brew install --cask karabiner-elements
brew install yqrashawn/goku/goku
goku

# Install asdf + plugins
println "Installing asdf..."
brew_install_or_upgrade 'asdf'

asdf plugin add nodejs
asdf install nodejs 14.16.1
asdf global nodejs 14.16.1

# zshell and oh-my-zshell
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  println "Installing oh my zshell..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  println "Installing zshell autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi



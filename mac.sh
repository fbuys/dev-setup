#!/usr/bin/env bash

if [[ ! -d "$HOME/.bin/" ]]; then
  mkdir "$HOME/.bin"
fi

if [[ ! -d "$HOME/.config/" ]]; then
  mkdir "$HOME/.config"
fi

if [[ ! -d "$HOME/.config/ctags" ]]; then
  mkdir "$HOME/.config"
fi

if [[ ! -d "$HOME/.git_template/hooks" ]]; then
  mkdir -p ~/.git_template/hooks
fi

if [ ! -f "$HOME/.bashrc" ]; then
  touch $HOME/.bashrc
fi

if [[ `uname -m` == 'arm64' ]]; then
  softwareupdate --install-rosetta
fi
script_dir=$(pwd) # store current working directory

println() {
  printf "%b\n" "$1"
}

if ! command -v brew &>/dev/null; then
  println "The missing package manager for OS X"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  if [ ! -f "$HOME/.bashrc" ]; then
    touch $HOME/.bashrc
  fi

  if ! grep -qs "recommended by brew doctor" ~/.bashrc; then
    println "Put Homebrew location earlier in PATH..."
      printf '\n# recommended by brew doctor\n' >> ~/.bashrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.bashrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
  println "Homebrew already installed. Skipping..."
fi


# Symlink dotfiles
dir=./dotfiles
home_files=".vimrc .tmux.conf .zshrc .gitconfig .gitignore .default-npm-packages"
config_files="karabiner.edn"
ctags_files="md.ctags"

if [[ -d $dir ]]; then
  cd $dir
  for file in $home_files; do
    if [[ -f $file ]]; then
      println "Creating symlink to $file in home directory."
      ln -sf $(pwd)/$file ~/$file
    fi
  done

  for file in $config_files; do
    if [[ -f $file ]]; then
      println "Creating symlink to $file in home/.config directory."
      ln -sf $(pwd)/$file ~/.config/$file
    fi
  done

  for file in $ctags_files; do
    if [[ -f $file ]]
    then
      echo "Creating symlink to $file in home/.config/ctags directory."
      ln -sf $(pwd)/$file ~/.config/ctags/$file
    fi
  done
fi

# Symlink git hooks
dir=./.git_template/hooks
hooks="ctags post-commit post-merge post-checkout post-rewrite"

if [[ -d $dir ]]
then
  cd $dir
  for file in $hooks; do
    if [[ -f $file ]]
    then
      println "Creating symlink to $file in git template directory."
      ln -sf $(pwd)/$file ~/$dir/$file
    fi
  done
fi

# Brew
if [[ -z "${UPGRADE_BREW}" ]]
then
  println "Updating Homebrew formulas..."
  brew update
  brew upgrade
  brew bundle --file $script_dir/BrewFile
fi

# asdf  plugins
println "Installing asdf plugins..."
asdf plugin add nodejs
asdf install nodejs 14.16.1
asdf global nodejs 14.16.1

asdf plugin-add yarn
asdf install yarn latest
yarn config set prefix ~/.yarn # To make sure yarn packages are globally accessible

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby 3.0.1
asdf install ruby 2.7.3
asdf global ruby 3.0.1

# zshell and oh-my-zshell
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  println "Installing oh my zshell..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

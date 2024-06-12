#!/usr/bin/env bash

script_dir=$(pwd) # store current working directory

println() {
  printf "%b\n" "$1"
}

mkdir_if_missing() {
  dir=$1
  if [[ ! -d $dir ]]; then
    println "Creating $dir..."
    mkdir -p $dir
  fi
}

symlink() {
  DIR="$(dirname "$1")"
  FILE="$(basename "$1")"
  TO=$2

  cd $DIR
  if [[ -f $FILE ]]; then
    println "Creating symlink to $FILE in $TO"
    ln -sf $(pwd)/$FILE $TO/$FILE
  fi
  cd -
}

if ! command -v brew &>/dev/null; then
  println "The missing package manager for OS X"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # ==> Next steps:
  # - Run these two commands in your terminal to add Homebrew to your PATH:
  #  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/ombulabs/.zprofile
  #  eval "$(/opt/homebrew/bin/brew shellenv)"

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

# Brew
if [[ ! -z "${UPGRADE_BREW}" ]]
then
  println "Updating Homebrew formulas..."
  brew update
  brew upgrade
  brew bundle --file $script_dir/BrewFile
fi

new_directories="$HOME/.bin $HOME/.git_template/hooks $HOME/.config/ctags $HOME/.config/pip"
for dir in "$new_directories"; do
  if [[ ! -d $dir ]]; then
    println "Creating $dir..."
    mkdir -p $dir
  fi
done

# nvim setup
mkdir_if_missing "$HOME/.config/nvim/lua/fbuys/plugins"
symlink ./nvim/init.lua $HOME/.config/nvim
symlink ./nvim/.luarc.json $HOME/.config/nvim

for file in nvim/lua/fbuys/*; do
  symlink $file $HOME/.config/nvim/lua/fbuys
done
for file in nvim/lua/fbuys/plugins/*; do
  symlink $file $HOME/.config/nvim/lua/fbuys/plugins
done

# nvim plugins config
# mkdir_if_missing "$HOME/.config/nvim/after/plugin"
# for file in nvim/after/plugin/*; do
#   symlink $file $HOME/.config/nvim/after/plugin
# done

# Clone Tmux Plugin Manager
# See: https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink dotfiles
dir=./dotfiles
home_files=".vimrc .tmux.conf .zshrc .gitconfig .gitignore .default-npm-packages .asdfrc"
config_files="karabiner.edn"
ctags_files="md.ctags"
nvim_files="coc-settings.json"
pip_files="pip.conf"

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

  for file in $nvim_files; do
    if [[ -f $file ]]
    then
      echo "Creating symlink to $file in home/.config/nvim directory."
      ln -sf $(pwd)/$file ~/.config/nvim/$file
    fi
  done

  for file in $pip_files; do
    if [[ -f $file ]]
    then
      echo "Creating symlink to $file in home/.config/pip directory."
      ln -sf $(pwd)/$file ~/.config/pip/$file
    fi
  done

  cd $script_dir
fi

# Symlink shell scripts
scripts_directory="$HOME/.scripts"
mkdir_if_missing $scripts_directory
if [[ -d "$scripts_directory" ]]; then
  for script_file in scripts/*; do
    # Check if the file is a regular file and is executable
    if [[ -f "$script_file" && -x "$script_file" ]]; then
      symlink "$script_file" "$scripts_directory"
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

if [[ ! -z "${WITH_ASDF}" ]]
then
# asdf  plugins
println "Installing asdf plugins..."
asdf plugin add nodejs
asdf install nodejs latest

asdf plugin-add yarn
asdf install yarn latest
yarn config set prefix ~/.yarn # To make sure yarn packages are globally accessible

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby latest

# asdf plugin-add crystal https://github.com/asdf-community/asdf-crystal.git
# asdf install crystal latest

asdf plugin add python
asdf install python latest
fi

# zshell and oh-my-zshell
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  println "Installing oh my zshell..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  touch $HOME/.secrets.sh
  mkdir_if_missing "$HOME/.zsh"
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# if [[ ! -d $HOME/git/github.com/dracula ]]; then
#   mkdir -p $HOME/git/github.com/dracula && cd $_
#   git clone https://github.com/dracula/iterm.git
#   cd "$script_dir"
# fi
if [[ ! -d $HOME/git/github.com/rose-pine ]]; then
  mkdir -p $HOME/git/github.com/rose-pine && cd $_
  git clone git@github.com:rose-pine/iterm.git
  cd "$script_dir"
fi
# Fonts
# curl -LJO https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip

# postgresql CLI tools
if [[ ! -d /etc/paths.d ]]; then
  sudo mkdir -p /etc/paths.d &&
    echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
fi

# Run karabiner
# goku

# PATH Export
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/Library/Python/3.9/bin:$HOME/git/github.com/goabstract/projects/stable/ops/bin:$PATH"
# /usr/local/opt/php@7.4/bin
# /usr/local/opt/php@7.4/sbin
path=(
  $path
  $HOME/.yarn/bin
  $HOME/.config/yarn/global/node_modules/.bin
  $HOME/.venv/
  $HOME/.composer/vendor/bin
  $HOME/.scripts
  /usr/local/opt/llvm/bin
  )

  # Multipass aliases
  # $HOME/Library/Application\ Support/multipass/bin
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(asdf bundler git gitfast rails zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# FZF file searching
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pure - Pretty, minimal and fast ZSH prompt
autoload -U promptinit; promptinit
prompt pure

# Some hub features feel best when it's aliased as git.
# Ref: https://github.com/github/hub#aliasing
# But this may interfere with gitfast
# eval "$(hub alias -s)"

# Prevent Brew analytics
export HOMEBREW_NO_ANALYTICS=1

# Crystal Config
# export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# Android Config
# export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
# export ANDROID_HOME=~/Library/Android/sdk/
# export PATH="$PATH:$ANDROID_HOME/platform-tools/"

# PHP config
# export LDFLAGS="-L/usr/local/opt/php@7.4/lib"
# export CPPFLAGS="-I/usr/local/opt/php@7.4/include"

# for tinyhood setup
# export ES_HOME=$HOME/elasticsearch-5.4.3
# export JAVA_HOME=$HOME/.asdf/plugins/java/set-java-home.zsh
# export PATH=$ES_HOME/bin:$JAVA_HOME/bin:$PATH

# For UpgradeJs setup
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Python config
# Why: To install or upgrade a global package
# and prevent installing glocal packages otherwise.
# Usage: gpip install --upgrade pip setuptools virtualenv
gpip(){
   PIP_REQUIRE_VIRTUALENV="0" python -m pip "$@"
}

# For asdf ruby
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# GO lang setup
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias glos="GIT_PAGER=cat glo --max-count=20"
alias ggpushf="ggpush --force-with-lease"
alias -g rnext="BUNDLE_GEMFILE=Gemfile.next"
alias gbDa="git branch |  grep -v "$(git_develop_branch)" | grep -v "$(git_main_branch)" | xargs git branch -D"

alias cdo="cd ~/git/github.com/ombulabs"
alias cdf="cd ~/git/github.com/fastruby"
alias cdfp="cd ~/git/github.com/fastruby/points"
alias cdg="cd ~/git/github.com/fbuys"
alias cdcx="cd ~/git/github.com/fbuys/r15-web-cx"
alias v="nvim ."
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias ombulabs="cd ~/git/github.com/fbuys/ombulabs"
alias francois="cd ~/git/github.com/fbuys/francois"
alias devsetup="cd ~/git/github.com/fbuys/dev-setup"
alias budget="cd ~/git/gitlab.com/buysfran/happybudget-cli"
alias cdtt="cd ~/git/github.com/fbuys/timetrap"
alias notes="cd ~/Google\ Drive/notes"
alias gdrive="cd /Volumes/GoogleDrive/My Drive"
alias icloud="cd /Users/francois/Library/Mobile\ Documents/com~apple~CloudDocs"
alias tt="cd ~/git/github.com/fbuys/timetracking && nvim ."
alias ww="curl wttr.in/Bothasig"
alias nnote="cd ~/git/github.com/fbuys/my-second-brain/0.inbox && nvim $(date +%Y_%m_%d).md"
alias fd='cd $(fzf | xargs dirname)'
# alias docker-compose="docker compose --compatibility $@"

# Source sensitive env
source ~/.secrets.sh

# Source personal scripts
# Specify the directory containing your scripts
# script_directory="$HOME/.scripts"

# Check if the directory exists
# if [[ -d "$script_directory" ]]; then
#     # Loop through the files in the directory
#     for script_file in "$script_directory"/*; do
#         # Check if the file is a regular file and is executable
#         if [[ -f "$script_file" && -x "$script_file" ]]; then
#             # Source the script
#             source "$script_file"
#         fi
#     done
# fi

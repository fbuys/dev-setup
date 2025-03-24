# On macOS, starting a Bash or Zsh shell automatically calls a utility called path_helper.
# path_helper can rearrange items in PATH (and MANPATH), causing inconsistent behavior for
# tools that require specific ordering. To workaround this, asdf on macOS defaults to
# forcily adding its PATH-entries to the front (taking highest priority). This is
# controllable with the ASDF_FORCE_PREPEND variable.
# See: https://asdf-vm.com/guide/getting-started.html
# export ASDF_FORCE_PREPEND="no"

# PATH Export
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/Library/Python/3.9/bin:$HOME/git/github.com/goabstract/projects/stable/ops/bin:$PATH"
# /usr/local/opt/php@7.4/bin
# /usr/local/opt/php@7.4/sbin
# path=(
#   $path
#   $HOME/.yarn/bin
#   $HOME/.config/yarn/global/node_modules/.bin
#   $HOME/.venv/
#   $HOME/.composer/vendor/bin
#   $HOME/.scripts
#   $HOME/.local/bin/
#   /usr/local/opt/llvm/bin
# )
path=(
  $path
  $HOME/.venv/
  $HOME/.scripts
  $HOME/.local/bin/
  /Applications/Postgres.app/Contents/Versions/latest/bin # for postress app
  ${ASDF_DATA_DIR:-$HOME/.asdf}/shims
)

  # Multipass aliases
  # $HOME/Library/Application\ Support/multipass/bin
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Could not get pure prompt to load
# See: https://github.com/sindresorhus/pure/issues/584
# See: https://github.com/sindresorhus/pure
fpath+=($HOME/.zsh/pure)

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
#
# Plugins
# z = Jump quickly to directories that you have visited "frecently." A native Zsh port of z.sh with added features.
# zsh-github-copilot = GitHub Copilot for your command line needs: git clone https://github.com/loiccoyle/zsh-github-copilot ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-github-copilot
plugins=(
  asdf
  bundler
  git
  gitfast
  rails
  z
  zsh-autosuggestions
  zsh-fzf-history-search
  zsh-github-copilot
  direnv
)

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
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi


# Github Copilot
bindkey '¿' zsh_gh_copilot_explain  # bind Option+shift+/ to explain
bindkey '÷' zsh_gh_copilot_suggest  # bind Option+/ to suggest

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
# On intel chip
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"
#
# On M3 chip, asdf install ruby latest
export RUBY_CONFIGURE_OPTS="--with-zlib-dir=$(brew --prefix zlib) --with-openssl-dir=$(brew --prefix openssl@3) --with-readline-dir=$(brew --prefix readline) --with-libyaml-dir=$(brew --prefix libyaml) --with-gdbm-dir=$(brew --prefix gdbm)"
export CFLAGS="-Wno-error=implicit-function-declaration"
# Older ruby version on M Chip
#
# # For asdf install ruby 2.*.*
# export optflags="-Wno-error=implicit-function-declaration"
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# export LDFLAGS="-L/opt/homebrew/opt/readline/lib -L/opt/homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/readline/include -I/opt/homebrew/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/readline/lib/pkgconfig /opt/homebrew/opt/openssl@1.1/pkgconfig"

# libpq is keg-only, which means it was not symlinked into /opt/homebrew,
# because conflicts with postgres formula.
#
# If you need to have libpq first in your PATH, run:
#   echo 'export PATH="/opt/homebrew/opt/libpq/bin:$PATH"' >> ~/.zshrc
#
# For compilers to find libpq you may need to set:
#   export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
#   export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
#
# For pkg-config to find libpq you may need to set:
#   export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# Disable Spring in Rails with `DISABLE_SPRING`
# spring makes dual booting harder.
export DISABLE_SPRING=true


# GO lang setup
export ASDF_GOLANG_MOD_VERSION_ENABLED=true


# Helper to retry failing tasks up to 20 times
# Specificially useful with kmonad
# See: https://github.com/kmonad/kmonad/issues/817#issuecomment-2002421584
retry() {
    local retries=20
    local delay=1
    local count=0

    while [[ $count -lt $retries ]]; do
        if "$@"; then
            return 0
        fi
        count=$((count + 1))
        sleep $delay
    done

    return 1
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias -g rnext="BUNDLE_GEMFILE=Gemfile.next"
alias budget="cd ~/git/gitlab.com/buysfran/happybudget-cli"
alias cdcx="cd ~/git/github.com/fbuys/r15-web-cx"
alias cdf="cd ~/git/github.com/fastruby"
alias cdfp="cd ~/git/github.com/fastruby/points"
alias cdg="cd ~/git/github.com/fbuys"
alias cdo="cd ~/git/github.com/ombulabs"
alias devsetup="cd ~/git/github.com/fbuys/dev-setup && nvim ."
alias docker-compose="docker compose --compatibility $@"
alias francois="cd ~/git/github.com/fbuys/francois"
alias gbDa="git branch |  grep -v "$(git_develop_branch)" | grep -v "$(git_main_branch)" | xargs git branch -D"
alias gdrive="cd /Volumes/GoogleDrive/My Drive"
alias ggpr="ggpull --rebase"
alias ggpushf="ggpush --force-with-lease"
alias glos="GIT_PAGER=cat glo --max-count=20"
alias icloud="cd /Users/francois/Library/Mobile\ Documents/com~apple~CloudDocs"
alias kmo2="retry sudo kmonad ~/git/github.com/fbuys/dev-setup/config_files/kmonad_2.kbd"
alias kmo="sudo kmonad ~/git/github.com/fbuys/dev-setup/config_files/kmonad.kbd"
alias nnote="cd ~/git/github.com/fbuys/my-second-brain/0.inbox && nvim $(date +%Y_%m_%d).md"
alias notes="cd ~/Google\ Drive/notes"
alias ombulabs="cd ~/git/github.com/fbuys/ombulabs"
alias tt="cd ~/git/github.com/fbuys/timetracking && nvim ."
alias v="nvim ."
alias vimrc="nvim ~/.config/nvim/init.lua"
alias ww="curl wttr.in/Bothasig"
alias zshrc="nvim ~/.zshrc"
alias aws-profile='export AWS_PROFILE=$(sed -n "s/\[profile \(.*\)\]/\1/gp" ~/.aws/config | fzf)'

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

### Zinit
# I don't think I need zinit when I use omz
#
# 🌻 Welcome!
#
# Now to get started you can check out the following:
# - The README section on the ice-modifiers:
#     🧊 https://github.com/zdharma-continuum/zinit#ice-modifiers
# - There's also an introduction to Zinit on the wiki:
#     📚 https://zdharma-continuum.github.io/zinit/wiki/INTRODUCTION/
# - The For-Syntax article on the wiki, which highlights some best practices:
#     📖 https://zdharma-continuum.github.io/zinit/wiki/For-Syntax/
#
# 💁 Need help?
# - 💬 Get in touch with us on Gitter: https://gitter.im/zdharma-continuum
# - 🔖 Or on GitHub: https://github.com/zdharma-continuum
# /var/folders/4h/k8vvz_210xq1ncr5m53z5sfw0000gn/T/tmp.XMspYJLURT/git-process-output.zsh
# /var/folders/4h/k8vvz_210xq1ncr5m53z5sfw0000gn/T/tmp.XMspYJLURT

### Added by Zinit's installer
# if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
#     print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
#     command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
#     command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
#         print -P "%F{33} %F{34}Installation successful.%f%b" || \
#         print -P "%F{160} The clone has failed.%f%b"
# fi
#
# source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit
#
# # Load a few important annexes, without Turbo
# # (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

### Krew for kubectl
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/ombulabs/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

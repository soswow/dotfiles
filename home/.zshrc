source $HOME/.bash_profile
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
alias zshconfig="code ~/.zshrc"
alias nuke="rm -rf"
alias nuke-node-modules="find . -name 'node_modules' -exec rm -rf '{}' +"
# Next one needs work
# alias nuke-dist="find . -name 'dist' -exec rm -rf '{}' +"
# alias ohmyzsh="code ~/.oh-my-zsh"

# Set this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often to auto-update? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to the command execution time stamp shown
# in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="%d/%m/%y %T"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git command-not-found cp npm node bower macos copyfile postgres)

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

alias ll='ls -la'
alias j7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias j8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
alias j10='export JAVA_HOME=$(/usr/libexec/java_home -v 10)'
export JAVA_HOME=$(/usr/libexec/java_home -v 10)  # default
setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.$1)
}

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/opt/ruby/bin:$HOME/.gems/bin:$HOME/.cargo/bin:$PATH"
export PATH="/Users/amotsjonov/Library/Android/sdk/platform-tools:$PATH"

# export VISUAL=code
#Cure for compass be not able to compile non-ascii characters
export LANG=en_US.UTF-8

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=524m"

#export RUBYOPT="-E utf-8"

export GEM_HOME="$HOME/.gems"
if [ -f "$HOME/.github_api_token" ]; then 
    source $HOME/.github_api_token
else
    echo -e "\e[31mWARNING! You don't have HOMEBREW_GITHUB_API_TOKEN. Put \nexport HOMEBREW_GITHUB_API_TOKEN=\"your_new_token\"\nto ~/.github_api_token\e[0m"
fi

if [ -f "/usr/local/opt/nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    . "/usr/local/opt/nvm/nvm.sh"
else
    echo -e "\e[31mWARNING: You probably want to install nvm. `brew install nvm` will do\e[0m"
fi

# export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/Developer/NVIDIA/CUDA-8.0/lib:$DYLD_LIBRARY_PATH

alias cors-chrome='open -a Google\ Chrome\ Canary --args --disable-web-security --user-data-dir'
# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/amotsjonov/work/webcore-next/desktop/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/amotsjonov/work/webcore-next/desktop/node_modules/tabtab/.completions/electron-forge.zsh

export PATH="$HOME/.config/yarn/global/node_modules/.bin:$HOME/.yarn/bin:$PATH"

# . ~/anaconda/etc/profile.d/conda.sh

alias merge-master-in='BRANCH=`git rev-parse --abbrev-ref HEAD`; git checkout master && git pull && git checkout "$BRANCH" && git merge master;'

alias merge-develop-in='BRANCH=`git rev-parse --abbrev-ref HEAD`; git checkout develop && git pull && git checkout "$BRANCH" && git merge develop;'

module-version() {
  str=`cat $1/package.json | grep -i '"version"'`
  echo $str
}

view-version() {
  npm view $1 version
}
alias last-branches='git for-each-ref --sort=committerdate refs/heads/'  
alias compress-last-screencast='ffmpeg -i "`ls -1 -t ~/Screenshots/*.mov | head -1`" -vcodec h264 "`ls -1 -t ~/Screenshots/*.mov | head -1 | sed 's/\.mov/\.mp4'/g`"'

remotecall(){
  echo "cd /mnt/volume2; ls -1 -t --escape | awk NR==${1-1}";
}
alias remove-brackets='sed -e "s/(/\\\\(/g" | sed -e "s/)/\\\\)/g" | sed -e "s/,/\\\\,/g" | sed -e "s/!/\\\\!/g" | sed -e "s/&/\\\\&/g"'
nth-nas-item(){
  ssh pi@192.168.1.113 "`remotecall $1`";
}
escaped-nas-item(){
  nth-nas-item $1 | remove-brackets
}
download-latest-nas(){
  rsync -r -P --progress --rsh=ssh "pi@192.168.1.113:/mnt/volume2/`escaped-nas-item $1`" ~/Downloads/;
}

alias pull-master='git checkout master && git pull'
alias new-master-branch="git fetch && git checkout origin/master && git checkout -b $1"
alias new-develop-branch="git fetch && git checkout origin/develop && git checkout -b $1"
alias git-checkout="git checkout $1"
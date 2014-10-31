export LANG=zh_TW.UTF-8
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad

HOME="/Users/alan"
BASH_HOME="$HOME/bash"

function alan {
  cd $HOME/Documents
  echo "Here is Documents home."
}

alias reload="source ~/.bash_profile"
alias composer="$BASH_HOME/plugins/composer.phar"
alias vim="open -a /Applications/MacVim.app $1"
alias ll="ls -all"

# git
# Get Git Branch information
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "("${ref#refs/heads/}") ";
}

function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));

    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

# Set PS1 color and git branch notification
PS1="[\[\033[1;32m\]\w\[\033[0m\]] \[\033[0m\]\[\033[1;36m\]\$(git_branch)\[\033[0;33m\]\$(git_since_last_commit)\[\033[0m\]$ "

[ -f $BASH_HOME/plugins/git-bash-completion.sh ] && . $BASH_HOME/plugins/git-bash-completion.sh
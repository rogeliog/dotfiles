alias g="git"
# ------------------------------------------------------------------------------
# Reload current shell
# ------------------------------------------------------------------------------
alias rl="source ~/.zshrc"

# ------------------------------------------------------------------------------
# Run tmux to make it work with colors
# ------------------------------------------------------------------------------
alias tmux="TERM=screen-256color-bce tmux"

# ------------------------------------------------------------------------------
# Setup NVM (Might not need this)
# ------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"


# ------------------------------------------------------------------------------
# Open a new PR for the current branch
# ------------------------------------------------------------------------------
function new_pr() {
  : ${BASE:=master}
  branch=`git rev-parse --abbrev-ref HEAD`

  git config --get remote.upstream.url > /dev/null 2>&1

  if [ $? -eq 0 ]
  then
    # New PR for forked repos
    url=`git config --get remote.upstream.url`
    user=`echo $url | sed s/.*github.com.// | cut -d '/' -f 1`
    repo=`echo $url | sed s/.*github.com.// | cut -d '/' -f 2`
    fork_url=`git config --get remote.origin.url`
    fork_user=`echo $fork_url | sed s/.*github.com.// | cut -d '/' -f 1`
    pr_url="https://github.com/$user/$repo/compare/$BASE...$fork_user:$branch"
  else
    # New PR for own repos
    url=`git config --get remote.origin.url`
    user=`echo $url | sed s/.*github.com.// | cut -d '/' -f 1`
    repo=`echo $url | sed s/.*github.com.// | cut -d '/' -f 2`
    pr_url="https://github.com/$user/$repo/compare/$BASE...$branch"
  fi

  open $pr_url
}

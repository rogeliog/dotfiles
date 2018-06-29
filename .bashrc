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
. "/usr/local/opt/nvm/nvm.sh"


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

# ------------------------------------------------------------------------------
# Open the PR in your browser for the current branch
# ------------------------------------------------------------------------------
function open_pr() {
    : ${REF:=HEAD}
  target=${1:-HEAD}
  pr=`git show-ref | grep $(git rev-parse $target) | grep /pr/[0-9]*$ -o | grep [0-9]*$ -o`
  
  git config --get remote.upstream.url > /dev/null 2>&1

  if [ $? -eq 0 ]
  then
    # New PR for forked repos
    url=`git config --get remote.upstream.url`
    user=`echo $url | sed s/.*github.com.// | cut -d '/' -f 1`
    repo=`echo $url | sed s/.*github.com.// | cut -d '/' -f 2`
    fork_url=`git config --get remote.origin.url`
    fork_user=`echo $fork_url | sed s/.*github.com.// | cut -d '/' -f 1`
    pr_url="https://github.com/$user/$repo/pull/$pr"
  else
    # New PR for own repos
    url=`git config --get remote.origin.url`
    user=`echo $url | sed s/.*github.com.// | cut -d '/' -f 1`
    repo=`echo $url | sed s/.*github.com.// | cut -d '/' -f 2`
    pr_url="https://github.com/$user/$repo/pull/$pr"
  fi

  open $pr_url
}
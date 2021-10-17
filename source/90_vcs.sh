#
# Git shortcuts
#
alias gp='git push'
alias gst='git status'
alias gb='git branch'
alias gcom='git checkout master'
alias gcl='git clone'
alias gr='git remote'

alias glxd="git pull xola development --tags"
alias glrxd="git pull --rebase xola development"
alias gcop="git checkout -- package-lock.json"

function glxm() {
  MAIN_BRANCH=`git branch -l master main | sed 's/^* //'`
  set -x
  git pull xola $MAIN_BRANCH --tags
  set +x
}

function glrxm() {
  MAIN_BRANCH=`git branch -l master main | sed 's/^* //'`
  set -x
  git pull --rebase xola $MAIN_BRANCH
  set +x
}

alias gh="hub" # Conflicts with Github's official cli.github.com tool

function ghpr() {
  MAIN_BRANCH=`git branch -l master main | sed 's/^* //'`
  set -x
  hub pull-request -o -b xola:$MAIN_BRANCH
  set +x
}

# add a github remote
function ghra() {
  if [[ "${#@}" -le 1 ]]; then
    echo "Usage: ghra [shortname] user/repo"
    return 1;
  fi

  git remote add "$1" "git@github.com:$2.git"
  echo -e "\nYour current remotes:"
  git remote -v
}

function ghfetch() {
    if [[ "${#@}" -ne 2 ]]; then
      echo "Usage: ghfetch [REMOTE] [BRANCH]"
      return 1;
    fi

    git fetch "$1" "$2"
    git checkout -t "$1/$2"
}

#
# Mercurial shortcuts
#
alias hst='hg status'
alias hgl='hg log'
alias hgp='echo "Too ambigous -- push (hgps) or pull (hgu)?"'
alias hgpu='hgp'
alias hgph='hgph'
alias hgu='hg pull'
alias hgps='hg push'

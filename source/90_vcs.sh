#
# Git shortcuts
#
alias gp='git push'
alias gst='git status'
alias gb='git branch'
alias gcl='git clone'
alias gr='git remote'
alias glxd="git pull xola development --tags"
alias glrxd="git pull --rebase xola development"
alias gcop="git checkout -- package-lock.json"
alias gpxm="echo 'You really want \"gpxm\"'"


function MAIN_BRANCH() {
  echo `git branch -l master main | sed 's/^* //'`
}

function gcom() {
  echo "$fg[magenta]Switching too `MAIN_BRANCH`${reset_color}"
  git checkout `MAIN_BRANCH`
}

function glxm() {
  echo "$fg[magenta]Pulling from xola `MAIN_BRANCH`${reset_color}"
  git pull xola `MAIN_BRANCH` --tags
}

function glrxm() {
  echo "$fg[magenta]Rebasing from xola `MAIN_BRANCH`${reset_color}"
  git pull --rebase xola `MAIN_BRANCH`
}

# function ghpr() {
#   hub pull-request -o -b xola:$MAIN_BRANCH
# }

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

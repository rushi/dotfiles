#
# Git shortcuts
#
alias gp='git push'
alias gst='git status'
alias gb='git branch'
alias gcom='git checkout master'
alias gcl='git clone'
alias gr='git remote'

alias gpxm="git pull xola master --tags"
alias gprxm="git pull --rebase xola master"
alias gcop="git checkout -- package-lock.json"

alias gh="hub" # Conflicts with Github's official cli.github.com tool
alias ghpr="hub pull-request -o -b xola:master"

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

# add a github remote by github username
function gra() {
  if (( "${#@}" != 1 )); then
    echo "Usage: gra githubuser"
    return 1;
  fi
  local repo=$(git remote show -n origin | perl -ne '/Fetch URL: .*github\.com[:\/].*\/(.*)/ && print $1')
  git remote add "$1" "git://github.com/$1/$repo"
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

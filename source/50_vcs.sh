#
# Git shortcuts
#
alias gp='git push'
alias gst='git status'
alias gb='git branch'
alias gba='git branch -a'
alias gcom='git checkout master'
alias gcl='git clone'
alias gclean='git reset --hard && git clean -f'

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

function gitreporefresh() {
    git pull upstream master
    git add .
    git commit -a -m "resync upstream on `date`"
    git push
    cd -
}

# OSX-specific Git shortcuts
if [[ "$OSTYPE" =~ ^darwin ]]; then
  alias gdkc='gdk --cached'
  if [ ! "$SSH_TTY" ]; then
    alias gd='gdk'
  fi
fi

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
alias ghpr="hub pull-request -o -b xola:master"

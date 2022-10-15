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
alias gpxm="echo 'You really want \"glxm\" (main|master) or \"glxd\"' (development)"
alias glog="git log --first-parent --no-merges --decorate --graph"
alias gcalint="git commit -am '🧹 Lint'"
alias gclint="git commit -m '🧹 Lint'"
alias hpox="hub push origin,xola"

function MAIN_BRANCH() {
  echo $(git branch -l development master main | head -1 | sed 's/^* //')
}

function REPO_NAME() {
  echo $(basename $(git remote get-url origin) .git)
}

function gcom() {
  git checkout $(MAIN_BRANCH)
}

function gcod() {
  git checkout $(MAIN_BRANCH)
}

function glxm() {
  echo "$fg[magenta]Pulling from xola $(MAIN_BRANCH)${reset_color}"
  git pull xola $(MAIN_BRANCH)
}

function glrxm() {
  echo "$fg[magenta]Rebasing from xola $(MAIN_BRANCH)${reset_color}"
  git pull --rebase xola $(MAIN_BRANCH)
}

function hubpr() {
  if [[ $1 == "--help" ]]; then
    echo "This will run $fg[magenta]hub pull-request -o -b xola:$(MAIN_BRANCH)${reset_color}"
    return
  fi
  hub pull-request -o -b xola:$(MAIN_BRANCH)
}

function ghpr() {
  if [[ $1 == "--help" ]]; then
    echo "This will run $fg[magenta]gh pr create -R xola/$(REPO_NAME) -B $(MAIN_BRANCH)${reset_color}"
    echo -e "\nYour options:"
    echo "   \$1 The user. This should be the github username, not remote"
    echo "   \$2 The branch"
    echo -e "\nIf you want to invoke gh directly, you can use:"
    echo "   -t, --title string   Title for the pull request"
    echo "   -d, --draft          Mark pull request as a draft"
    echo "   -H, --head branch    The branch that contains commits for your pull request (default: current branch)"
    echo "   -w, --web            Open the web browser to create a pull request"
    echo "   --recover string     Recover input from a failed run of create"
    return
  fi

  if [[ -z $1 ]]; then
    DEST_USER="xola"
  else
    DEST_USER=$1
  fi

  if [[ -z $2 ]]; then
    DEST_BRANCH=$(MAIN_BRANCH)
  else
    DEST_BRANCH=$2
  fi

  echo -e "PR to $fg[green]${DEST_USER}/"$(REPO_NAME) "${reset_color}on$fg[green]" ${DEST_BRANCH}${reset_color}
  gh pr create -R ${DEST_USER}/$(REPO_NAME) -B ${DEST_BRANCH}
}

# add a github remote
function ghra() {
  if [[ "${#@}" -le 1 ]]; then
    echo "Usage: ghra [shortname] user/repo"
    return 1
  fi

  git remote add "$1" "git@github.com:$2.git"
  echo -e "\nYour current remotes:"
  git remote -v
}

function ghfetch() {
  if [[ "${#@}" -ne 2 ]]; then
    echo "Usage: ghfetch [REMOTE] [BRANCH]"
    return 1
  fi

  git fetch "$1" "$2"
  git checkout -t "$1/$2"
  RETVAL=$?
  if [[ RETVAL -eq 128 ]]; then
    git checkout $2
  fi
}

function ghnew() {
  if [[ "${#@}" -ne 1 ]]; then
    echo "Usage: ghnew [BRANCH]"
    return 1
  fi

  echo "Checking out $(MAIN_BRANCH)"
  git checkout $(MAIN_BRANCH)
  # Check if exit code was zero
  if [[ $? -eq 0 ]]; then
    echo "Pulling latest $(MAIN_BRANCH) from xola"
    git pull xola $(MAIN_BRANCH)
    git checkout -b "$1"
  fi
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

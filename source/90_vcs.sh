#!/bin/bash

#
# Git shortcuts
#
alias gp='git push'
# alias gpfl='git push --force-with-lease'
alias gst='git status'
alias gb='git branch'
alias gcl='git clone'
alias gr='git remote'
alias glxd="git pull xola development --tags"
alias glrxd="git pull --rebase xola development"
alias gcop="git checkout -- package-lock.json"
alias gpxm="echo 'You really want \"glxm\" (main|master) or \"glxd\" (development)'"
alias glog="git log --decorate"
alias glog2="git log --first-parent --no-merges --decorate --graph"
alias gcalint="git commit -am '🧹 Lint'"
alias gclint="git commit -m '🧹 Lint'"
alias gclean="echo 'Do not use this'"
alias hpox="hub push origin,xola"

export DELTA_PAGER=less

function MAIN_BRANCH() {
  # shellcheck disable=SC2046 disable=SC2005
  echo $(git branch -l development x2-development x2 main master | head -1 | sed 's/^* //')
}

function REPO_NAME() {
  # shellcheck disable=SC2046 disable=SC2005
  echo $(basename $(git remote get-url origin) .git)
}

function CURRENT_BRANCH() {
  git rev-parse --abbrev-ref HEAD
}

function gcom() {
  git checkout "$(MAIN_BRANCH)"
}

function gcod() {
  git checkout "$(MAIN_BRANCH)"
}

function glxm() {
  # Check if 'xola' remote exists
  REMOTE="xola"
  if ! git remote get-url xola &>/dev/null; then
    REMOTE="origin"
  fi
  # shellcheck disable=SC2154
  echo "${fg[magenta]}Pulling from $REMOTE $(MAIN_BRANCH)${reset_color}"
  git pull "$REMOTE" "$(MAIN_BRANCH)"
}

function glrxm() {
  # Check if 'xola' remote exists
  REMOTE="xola"
  if ! git remote get-url xola &>/dev/null; then
    REMOTE="origin"
  fi

  echo "${fg[magenta]}Rebasing from $REMOTE $(MAIN_BRANCH)${reset_color}"
  git pull --rebase "$REMOTE" "$(MAIN_BRANCH)"
}

function ghpr() {
  if [[ $1 == "--help" || $1 == "-h" ]]; then
    # shellcheck disable=SC2154
    echo "This will run ${fg_bold[white]}gh pr create --repo xola/$(REPO_NAME) --base $(MAIN_BRANCH)${reset_color}"
    echo -e "\nYour options:"
    echo "   \$1 The user. This should be the github username, not remote"
    echo "   \$2 The branch"
    # echo -e "\nIf you want to invoke gh directly, you can use:"
    # echo "   -t, --title string   Title for the pull request"
    # echo "   -d, --draft          Mark pull request as a draft"
    # echo "   -H, --head branch    The branch that contains commits for your pull request (default: $(CURRENT_BRANCH))"
    # echo "   --recover string     Recover input from a failed run of create"
    return
  fi

  if [[ $1 == "view" ]]; then
    ghview -o
    return
  fi

  DEST_USER="${1:-xola}"
  DEST_BRANCH="${2:-$(MAIN_BRANCH)}"

  echo -e "PR to ${fg[green]}${DEST_USER}/""$(MAIN_BRANCH)" "${reset_color}on${fg[green]}" "${DEST_BRANCH}${reset_color}"
  gh pr create -R "${DEST_USER}"/"$(REPO_NAME)" -B "${DEST_BRANCH}"
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
    git checkout "$2"
  fi
}

function ghnew() {
  if [[ "${#@}" -ne 1 ]]; then
    echo "Usage: ghnew [BRANCH]"
    echo "Creates a new branch from $(MAIN_BRANCH)"
    return 1
  fi

  echo "Checking out $(MAIN_BRANCH)"
  if git checkout "$(MAIN_BRANCH)"; then
    echo "Pulling latest $(MAIN_BRANCH) from xola"
    git pull xola "$(MAIN_BRANCH)"
    git checkout -b "$1"
  fi
}

function getRemote() {
  # Check if there is a 'xola' origin remote if not use 'upstream' if present, otherwise use 'origin'
  if git remote get-url xola &>/dev/null; then
    echo "xola"
  elif git remote get-url upstream &>/dev/null; then
    echo "upstream"
  else
    echo "origin"
  fi
}

function ghview() {
  # Check if there is a 'xola' origin remote if not use 'upstream' if present, otherwise use 'origin'
  REPO_REMOTE=$(getRemote)
  if [[ -z $REPO_REMOTE ]]; then
    echo "No remote found. Please add a remote repository."
    return 1
  fi

  if [[ "$REPO_REMOTE" != "origin" ]]; then
    DATA=$(gh pr list --repo "$REPO_REMOTE"/"$(REPO_NAME)" --head "$(CURRENT_BRANCH)" --base "$(MAIN_BRANCH)" --state open --json "headRefName,title,url,createdAt,mergeable")
  else
    DATA=""
  fi
  ID=$(echo "$DATA" | jq -r ".[0].headRefName")
  if [[ $ID == "null" ]]; then
    echo "No PR found found for $(CURRENT_BRANCH) against $REPO_REMOTE/$(REPO_NAME)#$(MAIN_BRANCH)"
    gh pr list -R "$REPO_REMOTE"/"$(REPO_NAME)" --search "$(CURRENT_BRANCH)"
    return
  fi

  TITLE=$(echo "$DATA" | jq -r ".[0].title")
  URL=$(echo "$DATA" | jq -r ".[0].url")
  MERGE=$(echo "$DATA" | jq -r ".[0].mergeable")
  if [[ -z $ID ]]; then
    echo "PR ID not found. Try 'gh browse'"
    gh pr list -R "$REPO_REMOTE"/"$(REPO_NAME)" --search "$(CURRENT_BRANCH)"
    return
  else
    branch=$(CURRENT_BRANCH)
    JIRA_KEY=$(echo "$branch" | grep -oE '[A-Z][A-Z0-9]*-[0-9]+')
    JIRA_URL="https://xola01.atlassian.net/browse/$JIRA_KEY"
    printf "${fg[green]}Title:${reset_color} %s\n" "$TITLE"
    printf "${fg[green]}URL:${reset_color}   %s\n" "$URL"
    if [[ "$MERGE" != "MERGEABLE" ]]; then
      printf "${fg[green]}Merge:${reset_color} %s\n" "$MERGE"
    fi
    printf "${fg[green]}JIRA:${reset_color}  %s\n\n" "$JIRA_URL"
    if [[ $1 == "-o" ]]; then
      open "$URL"
    fi
    # gh run list --commit "$(git rev-parse HEAD)" -R xola/"$(REPO_NAME)"
    if [[ -z $1 ]]; then
      echo "${fg[gray]}Add -o to open the PR in the browser${reset_color}"
    fi
    echo "${fg[gray]}Use 'jira' command to open the JIRA ticket${reset_color}"
  fi
}

function ghact() {
  workflow=$1
  shift
  gh act "$workflow" --container-architecture linux/amd64 -s GITHUB_TOKEN="$(gh auth token)" -a "$(whoami)" "$@"
}

function ticket() {
  branch=$(CURRENT_BRANCH)
  jira_key=$(echo "$branch" | grep -oE '[A-Z][A-Z0-9]*-[0-9]+')
  if [ -n "$jira_key" ]; then
    jira_url="https://xola01.atlassian.net/browse/$jira_key"
    echo -e "Opening JIRA ticket: ${jira_key} ${jira_url}"
    open "$jira_url"
    if [[ $1 == "--pr" ]]; then
      ghview -o
    fi
  else
    echo "Unable to extract JIRA issue key from branch: '${branch}'"
  fi

  printf "\n${fg[gray]}%s${reset_color}\n" "'ghview' to open the pull request"
}
alias jira="ticket"

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

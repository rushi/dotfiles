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
alias gpxm="echo 'You really want \"glxm\" (main|master) or \"glxd\" (development)'"
alias glog="git log --decorate"
alias glog2="git log --first-parent --no-merges --decorate --graph"
alias gcalint="git commit -am '🧹 Lint'"
alias gclint="git commit -m '🧹 Lint'"
alias hpox="hub push origin,xola"

export DELTA_PAGER=less

function MAIN_BRANCH() {
  echo $(git branch -l development master main | head -1 | sed 's/^* //')
}

function REPO_NAME() {
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
  echo "${fg[magenta]}Pulling from xola $(MAIN_BRANCH)${reset_color}"
  git pull xola "$(MAIN_BRANCH)"
}

function glrxm() {
  echo "${fg[magenta]}Rebasing from xola $(MAIN_BRANCH)${reset_color}"
  git pull --rebase xola "$(MAIN_BRANCH)"
}

function hubpr() {
  if [[ $1 == "--help" ]]; then
    echo "This will run ${fg[magenta]}hub pull-request -o -b xola:$(MAIN_BRANCH)${reset_color}"
    return
  fi
  hub pull-request -o -b xola:"$(MAIN_BRANCH)"
}

function ghpr() {
  # // TODO: PR with flag
  if [[ $1 == "--help" ]]; then
    echo "This will run ${fg[magenta]}gh pr create -R xola/$(REPO_NAME) -B $(MAIN_BRANCH)${reset_color}"
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

  if [[ $1 == "view" ]]; then
    ghview -o
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

  echo -e "PR to ${fg[green]}${DEST_USER}/""$(MAIN_BRANCH)" "${reset_color}on${fg[green]}" "${DEST_BRANCH}${reset_color}"
  gh pr create -R "${DEST_USER}"/"$(REPO_NAME)" -B "${DEST_BRANCH}" --body ""
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
  git checkout "$(MAIN_BRANCH)"
  # Check if exit code was zero
  if [[ $? -eq 0 ]]; then
    echo "Pulling latest $(MAIN_BRANCH) from xola"
    git pull xola "$(MAIN_BRANCH)"
    git checkout -b "$1"
  fi
}

function ghview() {
  DATA=$(gh pr list --repo xola/"$(REPO_NAME)" --head "$(CURRENT_BRANCH)" --base "$(MAIN_BRANCH)" --state open --json "headRefName,title,url,createdAt,mergeable")
  ID=$(echo "$DATA" | jq -r ".[0].headRefName")
  if [[ $ID == "null" ]]; then
    echo "No PR found found for $(CURRENT_BRANCH) against xola/$(REPO_NAME)#$(MAIN_BRANCH)"
    gh pr list -R xola/"$(REPO_NAME)" --search "$(CURRENT_BRANCH)"
    return
  fi

  TITLE=$(echo "$DATA" | jq -r ".[0].title")
  URL=$(echo "$DATA" | jq -r ".[0].url")
  MERGE=$(echo "$DATA" | jq -r ".[0].mergeable")
  CREATED_AT=$(echo "$DATA" | jq -r ".[0].createdAt")
  if [[ -z $ID ]]; then
    echo "PR ID not found"
    gh pr list -R xola/"$(REPO_NAME)" --search "$(CURRENT_BRANCH)"
    echo "'jira' to open the JIRA ticket"
    return
  else
    JIRA_KEY=$(echo "$branch" | grep -oE '[A-Z][A-Z0-9]*-[0-9]+')
    JIRA_URL="https://xola01.atlassian.net/browse/$JIRA_KEY"
    printf "Title: ${fg[green]}%s${reset_color}\nURL:   ${fg[green]}%s${reset_color}\nDate:  %s\nMerge: %s\nJIRA:  ${fg[blue]}%s${reset_color}\n\n" "$TITLE" "$URL" "$CREATED_AT" "$MERGE" "$JIRA_URL"
    # noti -t "$TITLE" -m "ID: $ID"
    if [[ $1 == "-o" ]]; then
      open "$URL"
    fi
    gh run list --commit "$(git rev-parse HEAD)" -R xola/"$(REPO_NAME)"
    if [[ -z $1 ]]; then
      echo -e "\nAdd -o to open the PR in the browser"
    fi
    echo -e "Use 'jira' command to open the JIRA ticket"
  fi
}

function ghact() {
  workflow=$1
  shift
  gh act "$workflow" --container-architecture linux/amd64 -s GITHUB_TOKEN="$(gh auth token)" -a "$(whoami)" "$@"
}

function jira() {
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

  printf "\n${fg[green]}%s${reset_color}\n" "'ghview' to open the pull request"
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

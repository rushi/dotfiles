
# Git shortcuts

alias g='git'
function ga() { git add "${@:-.}"; } # Add all files by default
alias gp='git push'
alias gpa='gp --all'
alias gu='git pull'
alias gl='git log'
alias gg='gl --decorate --oneline --graph --date-order --all'
alias gs='git status'
alias gst='gs'
alias gd='git diff'
alias gdc='gd --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gba='git branch -a'
function gc() { git checkout "${@:-master}"; } # Checkout master by default
alias gco='gc'
alias gcb='gc -b'
alias gcl='git clone'
alias gdk='git diff'

alias hc='hg commit'
alias hcmm='hg commit -m "merge"'
alias hst='hg status'
alias hgl='hg log'
alias hgp='hg push'
alias hgpu='hg pull'

# open all changed files (that still actually exist) in the editor
function ged() {
  local files=()
  for f in $(git diff --name-only "$@"); do
    [ -e "$f" ] && files=("${files[@]}" "$f")
  done
  local n=${#files[@]}
  echo "Opening $n $([ "$@" ] || echo "modified ")file$([ $n != 1 ] && \
    echo s)${@:+ modified in }$@"
  q "${files[@]}"
}

# add a github remote by github username
function gra() {
  if (( "${#@}" != 1 )); then
    echo "Usage: gra githubuser"
    return 1;
  fi
  local repo=$(gr show -n origin | perl -ne '/Fetch URL: .*github\.com[:\/].*\/(.*)/ && print $1')
  gr add "$1" "git://github.com/$1/$repo"
}

# OSX-specific Git shortcuts
if [[ "$OSTYPE" =~ ^darwin ]]; then
  alias gdkc='gdk --cached'
  if [ ! "$SSH_TTY" ]; then
    alias gd='gdk'
  fi
fi

function svnstatus () {
    templist=`svn status $*`
    echo `echo $templist | grep '^?' | wc -l` unversioned files/directories
    echo $templist | grep -v '^?'
}

function svnup () {
    svn log --stop-on-copy -r HEAD:BASE $1
    svn up $1
}

function svndiff () {
    svn diff $* | /usr/local/Cellar/colordiff/1.0.9/bin/colordiff
}

function hgdiff () {
    hg diff $* | /usr/local/Cellar/colordiff/1.0.9/bin/colordiff
}

function hgstatus() {
    templist=`hg status $*`
    echo `echo $templist | grep '^?' | wc -l` unversioned files/directories
    echo $templist | grep -v '^?'
}

function gitreporefresh() {
    git pull upstream master 
    git add . 
    git commit -a -m "resync upstream on `date`"
    git push 
    cd -
}

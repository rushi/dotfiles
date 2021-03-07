# For git_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo "%{$fg_bold[white]%}§%{$reset_color%}" && return
    hg root >/dev/null 2>/dev/null && echo "%{$fg_bold[white]%}☿%{$reset_color%}" && return
    echo '○'
}

function hg_prompt_info {
  hg prompt --angle-brackets "\
< on %{$fg_bold[blue]%}<branch>%{$reset_color%}>\
< %{$fg_bold[magenta]%}(<bookmark>)%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function has_nvmrc {
  FILE=package.json
  if ! test -f "$FILE"; then
    # No need todo nvm check because package.json does not exist and this is not a node app
    return
  fi

  NVMRC=.nvmrc
  if ! test -f "$NVMRC"; then
    # No .nvmrc - no need to test this
    return
  fi

  echo "Node `cat .nvmrc`"
}

#$(hg_prompt_info)
PROMPT='
%{$fg[green]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info) $(has_nvmrc)
$(prompt_char) '

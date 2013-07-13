# Load npm_globals, add the default node into the path.
source ~/.dotfiles/source/50_devel.sh

# Add stuff here to Install Node.js.
# since we cant use nave (its bash-only)

# Todo: Install Npm modules.

# Install Ruby.
if [[ "$(type rbenv)" ]]; then
  versions=(1.9.3-p194 1.9.2-p290)

  list="$(to_install "${versions[*]}" "$(rbenv whence ruby)")"
  if [[ "$list" ]]; then
    e_header "Installing Ruby versions: $list"
    for version in $list; do rbenv install "$version"; done
    [[ "$(echo "$list" | grep -w "${versions[0]}")" ]] && rbenv global "${versions[0]}"
    rbenv rehash
  fi
fi

# Install Gems.
if [[ "$(type gem)" ]]; then
  gems=(bundler awesome_print interactive_editor)

  list="$(to_install "${gems[*]}" "$(gem list | awk '{print $1}')")"
  if [[ "$list" ]]; then
    e_header "Installing Ruby gems: $list"
    gem install $list
  fi
fi


# This file is sourced at the end of a first-time dotfiles install.
source ~/.zshrc

cat <<EOF
SSH Keys (if this is a server)
 1. (main) scp ~/.ssh/id_rsa.pub $USER@$(wanip):~/.ssh/
 2. (here) cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
 3. Make sure to copy your old authorized_keys file back!
EOF

#!/usr/bin/env bash

# Install with: sudo sed -i '/exit 0$/ i\/home/michel/dotfiles/freeinactiveuser.sh\n' /etc/rc.local

name=michel
days_inactive=5

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

last_access_text=$(last | grep -e "^$name" | head -1 | cut -c40-55)
last_access=$(date -d "$last_access_text" "+%s")

several_days_ago=$(date -d "today - $days_inactive days" "+%s")

# If user hasn't accessed the PC in several days (PC was stolen or the user died)
if (( several_days_ago > last_access ))
then
  # Remove password
  passwd -d $name
fi

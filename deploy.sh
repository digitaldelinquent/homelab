#! /usr/bin/env bash

cd /home/admin/homelab

# Fetch changes
git fetch

# Get hash for HEAD and remote
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

echo "| $(date) | Local: $LOCAL"
echo "| $(date) | Remote: $REMOTE"

# Check for changes in remote and local. If there are any pull the changes and
# apply them.
if [ $LOCAL!=$REMOTE ];
then
    echo "| $(date) | Difference detected, pulling latest changes..."
    git pull
    && sudo nixos-rebuild switch --flake . --impure
    && git add .
    && git commit -m "updating flake.lock file"
    && git push
    && docker compose up -d
else
    echo "| $(date) | No changes to be made"
fi



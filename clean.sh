#!/bin/bash

set -e

echo -e "[Starting cleanup]\n"

# Clean Nix store garbage
echo -e "[Nix garbage]\n"
sudo nix-collect-garbage -d

# Clean Nix store
# echo "Optimizing Nix store..."
# sudo nix-store --optimise

# Clean system logs (keep last 3 days)
echo -e "[System logs]\n"
sudo journalctl --vacuum-time=3d

# Clean user cache
echo -e "[User cache]\n"
rm -rf ~/.cache/*

# Clean Docker cache
echo -e "[Docker cache]"
if command -v docker &> /dev/null; then
    sudo docker system prune -af
fi

# Clean Go cache
echo -e "[Go cache]\n"
if [ -d ~/go/pkg ]; then
    go clean -modcache -cache
fi

# Clean temporary files
echo -e "[Tmp files]\n"
sudo rm -rf /tmp/*

# Clean thumbnail cache
echo -e "[Thumbnail cache]\n"
rm -rf ~/.cache/thumbnails/*

# Clean Trash
echo -e "[Trash]\n"
sudo trash-empty -f

echo "[Cleanup completed]"

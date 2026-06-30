#!/bin/sh

set -e

# If Packages aren't installed, install them.
if [ ! -d "Packages" ]; then
  sh scripts/install-packages.sh
fi

argon serve build.project.json \
  &
argon sourcemap default.project.json -o sourcemap.json --watch \
  &
ROBLOX_DEV=true darklua process --config .darklua.json --watch src/ dist/


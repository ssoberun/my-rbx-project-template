#!/bin/sh

set -e

wally install

# Patch the Wally package link modules to also export Luau type definitions.
argon sourcemap default.project.json -o sourcemap.json
~/nixdots/modules/features/packages/result/bin/wally-package-types --sourcemap sourcemap.json Packages/
~/nixdots/modules/features/packages/result/bin/wally-package-types --sourcemap sourcemap.json ServerPackages/

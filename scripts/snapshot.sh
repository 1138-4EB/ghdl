#!/usr/bin/env sh

snapshot="VERSION-RC"

git tag "$snapshot" "$(git rev-list -n 1 nightly)"
git push origin "$snapshot"

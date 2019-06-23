#!/bin/sh

set -e

cd $(dirname $0)

git clone -b gh-pages --depth 1 https://github.com/1138-4EB/ghdl _site

touch _site/.nojekyll

if [ -d _site/v0.36 ]; then
  rm -rf _site/v0.36
fi

mv _build/html _site/v0.36

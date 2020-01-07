#!/usr/bin/env sh

set -e

cd $(dirname $0)

if [ -d _build ]; then
  rm -rf _build
fi

if [ -d _site ]; then
  rm -rf _site
fi

ver=`grep "^ghdl_version=" ../configure | sed 's/.*"\(.*\)".*/\1/g'`
slug="v$ver"
if [ "x`printf "%s" $ver | tail -c 4`" = "x-dev" ]; then
  slug="master"
fi

mkdir -p "_site/$slug"
docpre="GHDL_doc_v${ver}"

docker build -t ghdl/sphinx -f- . <<EOF
FROM btdi/sphinx:featured
COPY requirements.txt /
RUN apk add -U --no-cache make \
 && pip3 install -r /requirements.txt \
 && pip3 install markdown2
EOF

dcmd="docker run --rm -u $(id -u) -v /$(realpath $(pwd)/..)://tmp/src -w //tmp/src/doc"

$dcmd -e GITHUB_SHA="$GITHUB_SHA" ghdl/sphinx sh -c "
set -e
python3 build.py --preset
make html latex man
python3 build.py --site
"

set +e

$dcmd btdi/latex:latest bash -c "
cd _build/latex
#make
pdflatex -interaction=nonstopmode GHDL.tex;
makeindex -s python.ist GHDL.idx;
pdflatex -interaction=nonstopmode GHDL.tex;
"

set -e

tar -czf "_site/${docpre}_html.tgz" -C _build/html .
tar -xf "_site/${docpre}_html.tgz" -C "_site/$slug" --strip-components=1
tar -czf "_site/${docpre}.tgz" -C _build .
cp _build/latex/*.pdf _site/${docpre}.pdf
cp _build/man/ghdl.1 _site/${docpre}_man.1

if [ -n "$CI" ]; then
  eval `ssh-agent -t 60 -s`
  echo "$GH_DEPKEY" | ssh-add -
  mkdir -p ~/.ssh/
  ssh-keyscan github.com >> ~/.ssh/known_hosts

  #branch="master"
  #repo="ghdl/ghdl.github.io"
  branch="gh-pages"
  repo="eine/ghdl"

  git clone -b "$branch" "git@github.com:$repo" gh-pages
  cd gh-pages

  rm -rf "$slug"
  mv ../_site/* ./
  touch .nojekyll "$slug/.nojekyll"

  git add .
  git status

  git config --local user.email "push@gha"
  git config --local user.name "GHA"
  git commit -am "update $GH_SHA"

  git push -u origin "+$branch"

  ssh-agent -k
else
  $(command -v winpty) docker run --name php --rm -itv /$(pwd)/_site://src -w //src -p 8000:8000 php sh -c "php -S 0.0.0.0:8000"
fi

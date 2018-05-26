#!/bin/sh

set -e # Exit with nonzero exit code if anything fails

. $(dirname $0)/ansi_color.sh

TARGET_BRANCH="gh-pages"
REPO=`git config remote.origin.url`

getWiki() {
    printf "\n${ANSI_MAGENTA}[GH-PAGES] Clone wiki${ANSI_NOCOLOR}\n"
    git clone "${REPO%.*}.wiki.git" content/wiki
    cd content/wiki
    rm -rf wip .git

    printf "\n${ANSI_MAGENTA}[GH-PAGES] Adapt wiki pages${ANSI_NOCOLOR}\n"
    for f in *.md; do
      sed -i -r 's/\[\[(.*)\|(.*)\]\]/[\1]({{< relref "wiki\/\2.md" >}})/g' ./*.md
      #name="$`sed -e 's/-/ /g' <<< $f`"
      #printf -- "---\ntitle: \"%s\"\ndescription: \"%s\"\ndate: \"%s\"\nlastmod: \"%s\"\n---\n$(cat $f)" "${name%.*}" "${f%.*}" $(git log -1 --format="%ai" -- "$f" | cut -c1-10) $(date +%Y-%m-%d -r "$f") > $f
    done;
}

if [ "$DEPLOY" = "" ]; then
    curl -L https://raw.githubusercontent.com/buildthedocs/btd/master/btd.sh | sh -s build -d -i doc -n "GHDL" -v "fix-doc"
    #builders,rtd2travis,ghdl-0.35
    mv ../btd_builds/html site/static/doc/

#    getWiki

    printf "\n${ANSI_MAGENTA}[GH-PAGES] Clone the '$TARGET_BRANCH' to 'out' and clean existing contents${ANSI_NOCOLOR}\n"
    git clone -b "$TARGET_BRANCH" "$REPO" ../out
    rm -rf ../out/**/* || exit 0

    set +e
    docker run --rm -t \
      -v /$(pwd):/src \
      -w //src/site \
      btdi/hugo -DEF -d hugo_out
    set -e
    cp -r site/hugo_out/. ../out

    rm -rf site/static/doc
else
    # Pull requests and commits to other branches shouldn't try to deploy, just build to verify
    if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
        printf "\nSkipping pages deploy\n"
        exit 0
    fi

    cd ../out

    git config user.name "Travis CI"
    git config user.email "travis@gh-pages"

    printf "\n${ANSI_MAGENTA}[GH-PAGES] Add changes${ANSI_NOCOLOR}\n"
    git add .
    # If there are no changes to the compiled out (e.g. this is a README update) then just bail.
    if [ $(git status --porcelain | wc -l) -lt 1 ]; then
        echo "No changes to the output on this push; exiting."
        exit 0
    fi
    git commit -am "deploy to github pages: `git rev-parse --verify HEAD`"

    printf "\n${ANSI_MAGENTA}[GH-PAGES] Get the deploy key${ANSI_NOCOLOR}\n"
    # by using Travis's stored variables to decrypt deploy_key.enc
    eval `ssh-agent -s`
    openssl aes-256-cbc -K $encrypted_0198ee37cbd2_key -iv $encrypted_0198ee37cbd2_iv -in ../ghdl-io/travis/deploy_key.enc -d | ssh-add -

    printf "\n${ANSI_MAGENTA}[GH-PAGES] Push to ${TARGET_BRANCH}${ANSI_NOCOLOR}\n"
    # Now that we're all set up, we can push.
    git push `echo $REPO | sed -e 's/https:\/\/github.com\//git@github.com:/g'` $TARGET_BRANCH
fi

#!/usr/bin/env bash

set -e
cd
DEPLOY_DIR=deploy

ls

git clone -q https://github.com/marufeuille/my-notebooks/ $DEPLOY_DIR
cd $DEPLOY_DIR
git checkout gh-pages

git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME


rm -rf *
cp -r ../docs/* .
echo $(ls)
echo $(pwd)

echo git add .
echo git commit -m "Deploy build $CIRCLE_BUILD_NUM [ci skip]" || true
echo git push origin gh-pages

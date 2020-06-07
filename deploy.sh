#!/usr/bin/env bash

set -e
DEPLOY_DIR=deploy

ls

git clone -q git@github.com:marufeuille/my-notebooks.git $DEPLOY_DIR
cd $DEPLOY_DIR
git checkout gh-pages

git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME


rm -rf *
cp -r ../docs/* .
echo $(ls)
echo $(pwd)

git add .
git commit -m "Deploy build $CIRCLE_BUILD_NUM [ci skip]" || true
git push origin gh-pages

#!/usr/bin/env bash

set -e

DEPLOY_DIR=deploy

git config --global push.default simple
git config --global user.email $(git --no-pager show -s --format='%ae' HEAD)
git config --global user.name $CIRCLE_USERNAME

echo $CIRCLE_REPOSITORY_URL
git clone -q --branch=gh-pages $CIRCLE_REPOSITORY_URL $DEPLOY_DIR

cd $DEPLOY_DIR
rsync -arv --delete ../docs/* .

echo git add -f .
echo git commit -m "Deploy build $CIRCLE_BUILD_NUM [ci skip]" || true
echo git push origin HEAD

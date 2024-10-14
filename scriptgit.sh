#!/bin/sh

COMENTARI=$1

git add .
git commit -m "$COMENTARI"
git push

#!/bin/bash

git add -A
git commit -am "update `date`"
git push origin master
if which gitbook > /dev/null; then
    cd NoteBook 
    gitbook build
    cd _book
    cp -R * ../../../NB-gitbook/
    cd ../../../NB-gitbook/
    git add -A
    git commit -am "update `date`"
    git push 
else
    echo "Gitbook is not installed."
fi

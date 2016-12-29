#!/bin/bash

if [ ! -d "../NB-gitbook/" ]; then
    cd ..
    mkdir NB-gitbook
    cd NB-gitbook
    git init
    git remote add origin git@github.com:Desgard/INoteBook.git
    git fetch
    git checkout gh-pages
    cd ../INoteBook
else
    cd ../NB-gitbook
    git pull origin gh-pages
    cd ../INoteBook
fi

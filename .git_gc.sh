#!/bin/bash
git reflog expire --all --expire=now && git gc --prune=now --aggressive
wd=./pack/packer/start
for i in $(sh -c "ls -d $wd/*/"); do
    pushd $i
    pwd
    git reflog expire --all --expire=now && git gc --prune=now --aggressive
    popd
done

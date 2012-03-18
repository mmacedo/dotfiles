#!/usr/bin/env bash

# For use with MSYS

echo ""
echo ""
echo "Welcome!"
echo ""
echo "here - current path Windows-style"
echo "shua - open current path in explorer"
echo "repos - list git repos in current folder"

alias ll='ls -al'
alias here="pwd | tr \'/\' \'\\\\\\\\\' | sed \"s/\\\\\\\\[a-z]/\\U&:/\" | sed \"s/\\\\\\\\//\""
alias shua='start `here`'
alias repos='find . -type d -maxdepth 1 | while read dir; do if [ -d "$dir/.git" ]; then echo $dir; fi; done;'
#!/usr/bin/env bash

# For use with MSYS

echo ""
echo ""
echo "Welcome!"
echo ""
echo "here - current path Windows-style"
echo "shua - open current path in explorer"

alias ll='ls -al'
alias here="pwd | tr \'/\' \'\\\\\\\\\' | sed \"s/\\\\\\\\[a-z]/\\U&:/\" | sed \"s/\\\\\\\\//\""
alias shua='start `here`'

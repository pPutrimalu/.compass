#!/usr/bin/env bash

sudo dnf install -y git gh glab

git config --global push.autoSetupRemote true
git config --global safe.directory '*'
git config --global helpers.credential store
git config --global init.defaultBranch main
git config --global rerere.enabled true
git config --global column.ui auto
git config --global branch.sort -committerdate

# Pushy - A Minimal Git Clone in Bash

## Overview
Pushy is a lightweight version control system implemented entirely in Bash. It replicates core `git` functionalities such as initializing repositories, adding and committing changes, creating and switching branches, and viewing file histories. I made Pushy for an assignment to help explore how version control works under the hood and improve my Bash scripting ability.

## Features
- **Initialization**: Set up a new repository (`pushy-init`).
- **Staging and Committing**: Track files and save changes with descriptive messages (`pushy-add`, `pushy-commit`).
- **Branching**: Create and switch between branches (`pushy-branch`, `pushy-checkout`).
- **Merging**: Merge branches with merge conflict detection (`pushy-merge`)
- **File History**: View specific versions of a file (`pushy-show`).
- **Conflict Management**: Prevent loss of uncommitted changes during branch operations.
- **File Removal**: Support for tracking deleted files (`pushy-rm`).

## Example Usage
```bash
# Initialize a repository
mkdir YOUR_REPO_NAME
cd YOUR_REPO_NAME
../pushy-init

# Add and commit files
echo "Hello, world!" > a
../pushy-add a
../pushy-commit -m "First commit"

# Create a branch and switch to it
../pushy-branch feature-branch
../pushy-checkout feature-branch

# Modify files and commit changes
echo "New content" > a
../pushy-add a
../pushy-commit -m "Feature update"

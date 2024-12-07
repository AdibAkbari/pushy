#!/bin/dash
export PATH=$PATH:$(pwd)

echo "test04 tests:"
# tests pushy-status

mkdir testrepo
cd testrepo

pushy-init
echo "Initialized empty pushy repository in .pushy"
touch a b c d e f g h
pushy-add a b c d e f
pushy-commit -m 'first commit'
echo "Committed as commit 0"
echo hello >a
echo hello >b
pushy-commit -a -m 'second commit'
echo "Committed as commit 1"
echo world >>a
echo world >>b
echo hello world >c
pushy-add a
echo world >>b
rm d
pushy-rm e
pushy-add g

echo "Checking status after various changes:"
output=$(pushy-status)
expected_output="a - file changed, changes staged for commit
b - file changed, changes not staged for commit
c - file changed, changes not staged for commit
d - file deleted
e - file deleted, deleted from index
f - same as repo
g - added to index
h - untracked
pushy-add - untracked
pushy-branch - untracked
pushy-checkout - untracked
pushy-commit - untracked
pushy-init - untracked
pushy-log - untracked
pushy-merge - untracked
pushy-rm - untracked
pushy-show - untracked
pushy-status - untracked
pushy.py - untracked"

# Comparing output with expected output can be tricky due to whitespace, line breaks, and order.
# Here's a simple comparison; consider a more robust method for real test scenarios.
if echo "$output" | grep -q -F "$expected_output"; then
    echo "\tpushy-status test passed"
else
    echo "\tpushy-status test failed"
    echo "\t\tExpected: $expected_output"
    echo "\t\tGot: $output"
fi


cd ..
rm -rf testrepo

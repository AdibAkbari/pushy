#!/bin/dash

export PATH=$PATH:$(pwd)

echo "Branching and merging test:"

mkdir testrepo
cd testrepo
pushy-init
echo "Initialized empty pushy repository in .pushy"

# Initial commit
seq 1 7 > 7.txt
pushy-add 7.txt
pushy-commit -m 'commit-1'
echo "Committed as commit 0"

# Branch and modify
pushy-branch b1
pushy-checkout b1
echo "Switched to branch 'b1'"
sed -Ei 's/2/42/' 7.txt
output1=$(cat 7.txt)
expected_output1="1
42
3
4
5
6
7"
pushy-commit -a -m 'commit-2'
echo "Committed as commit 1"

# Checkout master and verify content
pushy-checkout master
echo "Switched to branch 'master'"
output2=$(cat 7.txt)
expected_output2="1
2
3
4
5
6
7"

# Merge and verify content
pushy-merge b1 -m 'merge-message'
echo "Fast-forward: no commit created"
output3=$(cat 7.txt)
expected_output3="1
42
3
4
5
6
7"

# Check outputs
check_output() {
    if [ "$1" = "$2" ]; then
        echo "\tTest passed"
    else
        echo "\tTest failed"
        echo "\tExpected: $2"
        echo "\tGot: $1"
    fi
}

check_output "$output1" "$expected_output1"
check_output "$output2" "$expected_output2"
check_output "$output3" "$expected_output3"

cd ..
# rm -rf testrepo

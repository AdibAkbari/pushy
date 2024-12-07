#!/bin/dash
export PATH=$PATH:$(pwd)

echo "test03 tests:"
mkdir testrepo
cd testrepo
# tests pushy-rm


# - correct normal removal - file does not appear in subsequent commit
# - correct cached removal - deleting from index but not dir - after committing - is not in commit - but untracked changes in directory
# - correct forced removal

# errors:
# - pushy-rm: error: 'file' has staged changes in the index -> cached should still work
# - pushy-rm: error: 'a' is not in the pushy repository -> a only in dir, not index
# - pushy-rm: error: 'b' in the repository is different to the working file -> b not staged but different to latest b in a commit
# - pushy-rm: error: 'b' is not in the pushy repository -> b created just in directory - not in latest commit of repository - can be have b exactly the same in a previous commit - only based on latest commit
#              - both for cached and normal

pushy-init > /dev/null 2>&1

# normal

echo hello >a
echo hello >b
pushy-add a b
pushy-commit -m 'first commit' > /dev/null 2>&1
pushy-rm a
pushy-commit -m 'second commit' > /dev/null 2>&1

output1=$(pushy-show 1:a  2>&1)
expected_output1="pushy-show: error: 'a' not found in commit 1"
output2=$(cat a  2>&1)
expected_output2="cat: a: No such file or directory"

if [ "$output1" = "$expected_output1" ]; then
    echo "\tpushy-rm normal test index removal passed"
else
    echo "\tpushy-rm normal test index removal failed"
    echo "\t\tExpected: $expected_output1"
    echo "\t\tGot: $output1"
fi

if [ "$output2" = "$expected_output2" ]; then
    echo "\tpushy-rm normal test directory removal passed"
else
    echo "\tpushy-rm normal test directory removal failed"
    echo "\t\tExpected: $expected_output2"
    echo "\t\tGot: $output2"
fi

cd ..
rm -rf testrepo

# --cached
mkdir testrepo
cd testrepo
pushy-init > /dev/null 2>&1

echo hello >a
echo hello >b
pushy-add a b
pushy-commit -m 'first commit' > /dev/null 2>&1
pushy-rm --cached a
pushy-commit -m 'second commit' > /dev/null 2>&1

output1=$(pushy-show 1:a 2>&1)
expected_output1="pushy-show: error: 'a' not found in commit 1"
output2=$(cat a 2>&1)
expected_output2="hello"

if [ "$output1" = "$expected_output1" ]; then
    echo "\tpushy-rm cached test index removal passed"
else
    echo "\tpushy-rm cached test index removal failed"
    echo "\t\tExpected: $expected_output1"
    echo "\t\tGot: $output1"
fi

if [ "$output2" = "$expected_output2" ]; then
    echo "\tpushy-rm cached test file not removed from directory passed"
else
    echo "\tpushy-rm cached test file not removed from directory failed"
    echo "\t\tExpected: $expected_output2"
    echo "\t\tGot: $output2"
fi

echo "dogs" >> b

output=$(pushy-rm b 2>&1)
expected_output="pushy-rm: error: 'b' in the repository is different to the working file"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-rm error file changed not added test passed"
else
    echo "\tpushy-rm error file changed not added test failed"
    echo "\t\tExpected: $expected_output"
    echo "\t\tGot: $output"
fi

pushy-rm --cached b
output=$(pushy-rm b 2>&1)
expected_output="pushy-rm: error: 'b' is not in the pushy repository"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-rm error file removed from index and only in directory test passed"
else
    echo "\tpushy-rm error file removed from index and only in directory test failed"
    echo "\t\tExpected: $expected_output"
    echo "\t\tGot: $output"
fi

pushy-add a
output=$(pushy-rm a 2>&1)
expected_output="pushy-rm: error: 'a' has staged changes in the index"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-rm error staged changes test passed"
else
    echo "\tpushy-rm error staged changes test failed"
    echo "\t\tExpected: $expected_output"
    echo "\t\tGot: $output"
fi

echo "world" >> a
output=$(pushy-rm a 2>&1)
expected_output="pushy-rm: error: 'a' in index is different to both the working file and the repository"
if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-rm error file in index different to directory and repo test passed"
else
    echo "\tpushy-rm error file in index different to directory and repo test failed"
    echo "\t\tExpected: $expected_output"
    echo "\t\tGot: $output"
fi
output=$(pushy-rm a --cached --cached 2>&1)
if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-rm --cached error file in index different to directory and repo test passed"
else
    echo "\tpushy-rm --cached error file in index different to directory and repo test failed"
    echo "\t\tExpected: $expected_output"
    echo "\t\tGot: $output"
fi


output=$(pushy-rm -cachd a 2>&1)
usage_error_output="usage: pushy-rm [--force] [--cached] <filenames>"

if [ "$output" = "$usage_error_output" ]; then
    echo "\tpushy-rm usage error test 1 passed"
else
    echo "\tpushy-rm usage error test 1 failed"
    echo "\t\tExpected: $usage_error_output"
    echo "\t\tGot: $output"
fi

output=$(pushy-rm --cached a --force b 2>&1)
usage_error_output="usage: pushy-rm [--force] [--cached] <filenames>"

if [ "$output" = "$usage_error_output" ]; then
    echo "\tpushy-rm usage error test 2 passed"
else
    echo "\tpushy-rm usage error test 2 failed"
    echo "\t\tExpected: $usage_error_output"
    echo "\t\tGot: $output"
fi

output=$(pushy-rm -cached a b --force 2>&1)
usage_error_output="usage: pushy-rm [--force] [--cached] <filenames>"

if [ "$output" = "$usage_error_output" ]; then
    echo "\tpushy-rm usage error test 3 passed"
else
    echo "\tpushy-rm usage error test 3 failed"
    echo "\t\tExpected: $usage_error_output"
    echo "\t\tGot: $output"
fi

output=$(pushy-rm --cached a b --force -de 2>&1)
usage_error_output="usage: pushy-rm [--force] [--cached] <filenames>"

if [ "$output" = "$usage_error_output" ]; then
    echo "\tpushy-rm usage error test 4 passed"
else
    echo "\tpushy-rm usage error test 4 failed"
    echo "\t\tExpected: $usage_error_output"
    echo "\t\tGot: $output"
fi

cd ..
rm -rf testrepo

#!/bin/dash
export PATH=$PATH:$(pwd)

echo "test01 tests:"
mkdir testrepo
cd testrepo

pushy-init > /dev/null 2>&1

output=$(pushy-log 2>&1)
expected_output=""

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-log no commits test passed"
else
    echo "\tpushy-log no commits test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

echo "line 1" > a
echo hello world >b

pushy-add a b
pushy-commit -m 'first commit' > /dev/null 2>&1

echo  "line 2" >>a
pushy-add a
pushy-commit -m 'second commit' > /dev/null 2>&1

output=$(pushy-log 2>&1)
expected_output="1 second commit
0 first commit"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-log test passed"
else
    echo "\tpushy-log test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# testing pushy-show.
# - usage1
output1=$(pushy-show 2>&1)
expected_output="usage: pushy-show <commit>:<filename>"

if [ "$output1" = "$expected_output" ]; then
    echo "\tpushy-show usage test 1 passed"
else
    echo "\tpushy-show usage test 1 failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# - usage2
output2=$(pushy-show 0:a d 2>&1)
if [ "$output2" = "$expected_output" ]; then
    echo "\tpushy-show usage test 2 passed"
else
    echo "\tpushy-show usage test 2 failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# - usage3
output3=$(pushy-show 0a 2>&1)
if [ "$output3" = "$expected_output" ]; then
    echo "\tpushy-show usage test 3 passed"
else
    echo "\tpushy-show usage test 3 failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# - unknown commit
output=$(pushy-show 5:a 2>&1)
expected_output="pushy-show: error: unknown commit '5'"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-show unknown commit test passed"
else
    echo "\tpushy-show unknown commit test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# - unknown file in commit
output=$(pushy-show 1:c 2>&1)
expected_output="pushy-show: error: 'c' not found in commit 1"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-show unknown file commit test passed"
else
    echo "\tpushy-show unknown file commit test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# - unknown file in index
output=$(pushy-show :c 2>&1)
expected_output="pushy-show: error: 'c' not found in index"

if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-show unknown file index test passed"
else
    echo "\tpushy-show unknown file index test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

echo "line 3" >>a
pushy-add a
echo "line 4" >>a

# - known file in commit
output=$(pushy-show 1:a 2>&1)
expected_output="line 1
line 2"
if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-show commit test passed"
else
    echo "\tpushy-show commit test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

# - known file in index
output=$(pushy-show :a 2>&1)
expected_output="line 1
line 2
line 3"
if [ "$output" = "$expected_output" ]; then
    echo "\tpushy-show index test passed"
else
    echo "\tpushy-show index test failed"
    echo "\t\tExpected:\n$expected_output"
    echo "\t\tGot:\n$output"
fi

cd ..
rm -rf testrepo

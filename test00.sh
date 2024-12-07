#!/bin/dash
export PATH=$PATH:$(pwd)

echo "test00 tests:"

mkdir testrepo
cd testrepo

expected_init_output="Initialized empty pushy repository in .pushy"
init_output=$("pushy-init" 2>&1) # Capture both stdout and stderr

if [ "$init_output" = "$expected_init_output" ]; then
    echo "\tpushy-init test passed"
else
    echo "\tpushy-init test failed"
    echo "\t\tExpected: $expected_init_output"
    echo "\t\tGot: $init_output"
fi

expected_init_output="pushy-init: error: .pushy already exists"
init_output=$("pushy-init" 2>&1)

if [ "$init_output" = "$expected_init_output" ]; then
    echo "\tpushy-init already exists test passed"
else
    echo "\tpushy-init already exists test failed"
    echo "\t\tExpected: $expected_init_output"
    echo "\t\tGot: $init_output"
fi


echo "hello" > world.txt
pushy-add world.txt

if [ -f ".pushy/index/world.txt" ]; then
    echo "\tpushy-add test passed"
else
    echo "\tpushy-add test failed"
    echo "\t\tFile 'world.txt' was not added to the index correctly."
fi

expected_com_output="usage: pushy-commit [-a] -m commit-message"
com_output=$("pushy-commit" 2>&1)

if [ "$com_output" = "$expected_com_output" ]; then
    echo "\tpushy-commit usage test passed"
else
    echo "\tpushy-commit usage test failed"
    echo "\t\tExpected: $expected_com_output"
    echo "\t\tGot: $com_output"
fi

expected_com_output="Committed as commit 0"
com_output=$("pushy-commit" -m "testcommit" 2>&1)

if [ "$com_output" = "$expected_com_output" ]; then
    echo "\tpushy-commit commit 0 test passed"
else
    echo "\tpushy-commit commit 0 test failed"
    echo "\t\tExpected: $expected_com_output"
    echo "\t\tGot: $com_output"
fi

expected_com_output="nothing to commit"
com_output=$("pushy-commit" -m "testcommit1" 2>&1)

if [ "$com_output" = "$expected_com_output" ]; then
    echo "\tpushy-commit nothing to commit test passed"
else
    echo "\tpushy-commit nothing to commit test failed"
    echo "\t\tExpected: $expected_com_output"
    echo "\t\tGot: $com_output"
fi

echo "hello2" > world2.txt
pushy-add world2.txt

expected_com_output="Committed as commit 1"
com_output=$("pushy-commit" -m "testcommit1" 2>&1)

if [ "$com_output" = "$expected_com_output" ]; then
    echo "\tpushy-commit commit 1 test passed"
else
    echo "\tpushy-commit commit 1 test failed"
    echo "\t\tExpected: $expected_com_output"
    echo "\t\tGot: $com_output"
fi


cd ..
rm -rf testrepo

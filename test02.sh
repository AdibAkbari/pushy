#!/bin/dash
export PATH=$PATH:$(pwd)

echo "test02 tests:"

commands="pushy-add pushy-commit pushy-log pushy-show pushy-rm pushy-status pushy-branch pushy-checkout pushy-merge"

expected_output=": error: pushy repository directory .pushy not found"

mkdir testrepo
cd testrepo

for cmd in $commands; do
    output=$("$cmd" 2>&1)

    if echo "$output" | grep -q "$expected_output"; then
        echo "\t$cmd .pushy not found test passed"
    else
        echo "\t$cmd .pushy not found test failed"
        echo "\t\tExpected: *$expected_output"
        echo "\t\tGot: $output"
    fi
done

cd ..
rm -rf testrepo

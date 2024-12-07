#!/bin/dash
export PATH=$PATH:$(pwd)

# Navigate to the testscripts directory
mkdir testrepo
cd testrepo

pushy-init > /dev/null 2>&1

# Run the implemented pushy command and capture its output
output=$(pushy-log 2>&1)

# Expected output from the reference implementation
expected_output=""

# Compare the actual output to the expected output
if [ "$output" = "$expected_output" ]; then
    echo "pushy-log test passed"
else
    echo "pushy-log test failed"
    echo "Expected: $expected_output"
    echo "Got: $output"
fi

# Cleanup
cd ..
rm -rf testrepo

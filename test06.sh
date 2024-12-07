#!/bin/dash
export PATH=$PATH:$(pwd)

# Navigate to the testscripts directory
cd "$(dirname "$0")"

# Create and enter the testrepo directory
mkdir -p testrepo
cd testrepo

# Run the implemented pushy command and capture its output
output=$(pushy-init 2>&1)

# Expected output from the reference implementation
expected_output="Initialized empty pushy repository in .pushy"

# Compare the actual output to the expected output
if [ "$output" = "$expected_output" ]; then
    echo "pushy-init test passed"
else
    echo "pushy-init test failed"
    echo "Expected: $expected_output"
    echo "Got: $output"
fi

# Cleanup
cd ..
rm -rf testrepo

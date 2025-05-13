#!/bin/bash

# Replace 'your_script.sh' with the path to the script you want to run
for i in {1..10}
do
    echo "Run #$i"
    ./accuracy_script.sh run_all
done

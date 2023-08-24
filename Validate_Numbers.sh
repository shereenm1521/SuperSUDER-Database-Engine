#!/usr/bin/bash

fun_validate_number() {
    
    # Regular expression to check for valid name (starts with a letter and contains only letters, numbers, or underscores)
    pattern="^[0-9]+$"

    if [[ $1 =~ $pattern ]]; then
        return 0
    else
        return 1
    fi
}

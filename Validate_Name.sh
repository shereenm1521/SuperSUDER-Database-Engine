#!/usr/bin/bash

fun_validate_name() {
    
    # Regular expression to check for valid name (starts with a letter and contains only letters, numbers, or underscores)
    pattern="^[a-zA-Z][a-zA-Z0-9_]*$"

    if [[ $1 =~ $pattern ]]; then
        return 0
    else
        return 1
    fi
}

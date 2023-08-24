#!/usr/bin/bash

fun_create_database() {

    clear
    # Prompt the user to enter the database name
    read -p "Enter the database name: " db_name

    if  fun_validate_name "$db_name" ; then
       if [ -d "./Data/$db_name" ]; then
            echo "Error: Database already exists."
            sleep 2
            clear
            fun_header_note
            fun_create_database
        else
            mkdir "./Data/$db_name"
            fun_success "Database created successfully."
            sleep 2
            clear
            fun_super_menu
        fi
    else
        fun_error "Error: Invalid database name."
        sleep 3
        fun_create_database
    fi
}

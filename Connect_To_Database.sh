#!/usr/bin/bash

fun_connect_to_databases() {

    #Get number of Databases
    count=$(ls ./Data | wc -l)
    #Check is Empty or not
    if [ "$count" -eq 0 ]; then
        clear
        fun_empty_databases
        sleep 2
        clear
        fun_header_note
        fun_super_menu
    else

        echo
        cd ./Data
        echo "Select your database from the menu:"
        array=$(ls -d */ | sed 's/[/]//')
        select name in ${array[*]}; do
            if [[ -d $name ]]; then
                cd "$name"
                fun_success "You are connected to: $name ..."
                sleep 2
                clear
                fun_header_note
                fun_table_menu
                break
            else
                fun_error "Database does not exist. Please enter a valid name."
            fi
        done
    fi
}


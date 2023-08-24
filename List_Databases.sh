#!/usr/bin/bash

function fun_list_databases {

    clear
    fun_header_note
    arr=(./Data/*)
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

        echo "╔══════════════════════════════════╗"
        echo "║        Available Databases       ║"
        echo "╠════════╦═════════════════════════╣"
        echo "║ Option ║     Description         ║"
        echo "╠════════╩═════════════════════════╣"
        counter=1
        for db in "${arr[@]}"; do
            db_name=$(basename "$db")
            echo "║   $counter         $db_name "
            if [ "$db" == "${arr[-1]}" ]; then
                echo "╚══════════════════════════════════╝"
            else
                echo "╠══════════════════════════════════╣"
            fi
            ((counter++))
        done
        echo
        sleep 3
        fun_super_menu

    fi

}


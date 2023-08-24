#!/usr/bin/bash

function fun_drop_database {

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
        clear
        arr=(./Data/*)
        echo "╔══════════════════════════════════╗"
        echo "║        Available Databases       ║"
        echo "╠════════╦═════════════════════════╣"
        echo "║ Option ║     Description         ║"
        echo "╠════════╩═════════════════════════╣"
        counter=1
        for db in "${arr[@]}"; do
            db_name=$(basename "$db")
            echo "║   $counter           $db_name "
            if [ "$db" == "${arr[-1]}" ]; then
                echo "╚══════════════════════════════════╝"
            else
                echo "╠══════════════════════════════════╣"
            fi
            ((counter++))
        done
        echo
        read -p "Enter the number of the database: " delete_number

        if [[ $delete_number =~ ^[0-9]+$ ]]; then
            if [ "$delete_number" -ge 1 ] && [ "$delete_number" -le "${#arr[@]}" ]; then
                deleted_db="${arr[$((delete_number - 1))]}"
                rm -r "$deleted_db"  # Delete the database directory
                fun_success "Database '$(basename "$deleted_db")' has been deleted..."
                sleep 3
                clear
                fun_header_note
                fun_super_menu
            else
                echo "Invalid database number."
                sleep 3
                fun_drop_database
            fi
        else
            fun_error "Invalid input. Please enter a valid number."
            sleep 3
            fun_drop_database
        fi
    fi

}

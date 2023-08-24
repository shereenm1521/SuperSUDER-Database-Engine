#!/usr/bin/bash

fun_list_tables() {
    

    #Get number of Databases
    count=$(ls | wc -l)
    #Check is Empty or not
    if [ "$count" -eq 0 ]; then
    
        clear
        fun_empty_tables
        sleep 2
        clear
        fun_header_note
        fun_table_menu
    else
        
        clear
        # Get array of table names
        arr=($(ls -F | grep -v '_metadata' | sed 's/_data$//'))
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
        sleep 2
        fun_table_menu 
      
    fi
}



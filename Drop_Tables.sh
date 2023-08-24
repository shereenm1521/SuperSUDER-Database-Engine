#!/usr/bin/bash

fun_drop_table() {

    
    
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
        mytables=($(ls -F | grep -v '_metadata' | sed 's/_data$//'))
        counter=1
        echo "╔══════════════════════════════════╗"
        echo "║         Available Tables         ║"
        echo "╠════════╦═════════════════════════╣"
        echo "║ Option ║     Description         ║"
        echo "╠════════╩═════════════════════════╣"
        for table in "${mytables[@]}"; do
            echo "║   $counter         $table "
            if [ "$table" == "${mytables[-1]}" ]; then
                echo "╚══════════════════════════════════╝"
            else
                echo "╠══════════════════════════════════╣"
            fi
            ((counter++))
        done
        echo
        read -p "Enter the number of the Table: " delete_number

        if [[ $delete_number =~ ^[0-9]+$ ]]; then
            if [ "$delete_number" -ge 1 ] && [ "$delete_number" -le "${#mytables[@]}" ]; then
                deleted_table="${mytables[$((delete_number - 1))]}"
                rm -r "${deleted_table}_metadata" "${deleted_table}_data"
                fun_success "Table \"${deleted_table}\" has been deleted..."
                sleep 3
                clear
                fun_table_menu
            else
                fun_error "Invalid table number."
                sleep 3
                fun_drop_table
            fi
        else
            fun_error "Invalid input. Please enter a valid number."
            sleep 3
            fun_drop_table
        fi
        
    fi
}

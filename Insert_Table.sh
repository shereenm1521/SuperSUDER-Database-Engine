#!/bin/bash

fun_check_pk() {

    #$1 => input_value, $2 => tableName_data
    col_num="$((i - 1))"
    if [ "${colpk_array[$((i - 1))]}" == "yes" ]; then

        colDataCount=$(cat ${current_table}_data | cut -d : -f $i | grep ^"$current_column"$ |wc -l)
        if [ $colDataCount -gt 0 ]; then
            fun_error "Primary Key is already Exist"
            sleep 3
            fun_insert_table
        fi

    fi
}


fun_insert_table() {


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
            echo "║   $counter           $table "
            if [ "$table" == "${mytables[-1]}" ]; then
                echo "╚══════════════════════════════════╝"
            else
                echo "╠══════════════════════════════════╣"
            fi
            ((counter++))
        done
        echo 
        read -p "Enter the number of the Table: " table_number

        if [[ $table_number =~ ^[0-9]+$ ]]; then
            if [ "$table_number" -ge 1 ] && [ "$table_number" -le "${#mytables[@]}" ]; then
                current_table="${mytables[$((table_number - 1))]}"

                # Extract line 1 
                sed -n '1p;1q' "${current_table}_metadata" > tmpfile
                read -r colnames < tmpfile
                # Extract line 2
                sed -n '2p;2q' "${current_table}_metadata" > tmpfile
                read -r coltypes < tmpfile 
                # Extract line 3
                sed -n '3p;3q' "${current_table}_metadata" > tmpfile
                read -r colpk < tmpfile
                rm tmpfile
                # Split the columns into arrays & Replace : with spaces
                colnames_array=(${colnames//:/ })
                coltypes_array=(${coltypes//:/ }) 
                colpk_array=(${colpk//:/ })
                #columns count
                columns_count=${#colnames_array[@]}
                for ((i=1;i<=$columns_count;i++)); do
                    #Check the current column is string or int 
                    strFlag=0
                    while [ $strFlag != 1 ]; do
                        read -p "Enter the \"${colnames_array[$((i - 1))]}\": " current_column
                        if [ "${coltypes_array[$((i - 1))]}" == "string" ]; then
                            #Check the string is valid or not
                            if fun_validate_name "$current_column"; then
                                #Check is Primary Key or not
                                fun_check_pk
                                if [ $i == $columns_count ]; then
                                    finalData+="$current_column"
                                else
                                    finalData+="$current_column:"
                                fi
                                strFlag=1
                            else
                                fun_error "This column should be only \""${coltypes_array[$((i - 1))]}"\"" 
                                echo
                            fi  
                        elif [ "${coltypes_array[$((i - 1))]}" == "number" ]; then
                            #Check the number is valid or not
                            if fun_validate_number "$current_column"; then
                                #Check is Primary Key or not
                                fun_check_pk
                                if [ $i == $columns_count ]; then
                                    finalData+="$current_column"
                                elif [[ $i -lt $columns_count ]]; then
                                    finalData+="$current_column:"

                                fi
                                strFlag=1
                            else
                                fun_error "This column should be only \""${coltypes_array[$((i - 1))]}"\"" 
                                echo
                            fi
                        else 
                            fun_error "This column should be only \""${coltypes_array[$((i - 1))]}"\"" 
                            echo
                        fi
                    done
                done
                echo 
                #Insert Data into the Table Data File
                echo -e "$finalData" >> "./${current_table}_data"
                finalData=""
                # fun_success "Table has been Inserted successfully..."
                # sleep 3
                # clear
                # fun_table_menu
                if [ ! $columns_count -eq 0 ]; then
                    fun_success "Table has been Inserted successfully..."
                    sleep 3
                    clear
                    fun_table_menu

                else
                    #clear
                    fun_error "Table is empty"
                    sleep 3
                    fun_insert_table
                fi

            else
                fun_error "Invalid table number."
                sleep 3
                fun_insert_table
            fi
        else
            fun_error "Invalid input. Please enter a valid number."
            sleep 3
            fun_insert_table
        fi
    fi
}
#!/usr/bin/bash


fun_create_table() {

    clear

    # Get Table name 
    echo -e "Enter The Table Name: \c" 
    read tableName
    # check the table name is valid or not
    if fun_validate_name "$tableName"; then
        # Valid Name
        #Check if the table exist or not
        if [ -e "./${tableName}_data" ] && [ -e "./${tableName}_metadata" ]; then
            fun_error "The Table already exists."
            sleep 2
            clear
            fun_create_table
        fi
        echo -e "Enter Columns Count: \c" 
        read columnCount
        if fun_validate_number "$columnCount"; then
            #Valid Columns Count
            metaName=""
            metaType=""
            pKey="no"
            metaPK=""
            for ((i = 1; i <= $columnCount; i++)); do
                echo
                echo -e "Enter Column Name: \c"
                read columnName
                if fun_validate_name "$columnName"; then
                    #Choose Type ("String","Number")
                    echo "Enter the number of type:"
                    select type in "String" "Number"; do
                        case $type in
                            "String")
                                type="string"
                                break
                                ;;
                            "Number")
                                type="number"
                                break
                                ;;
                            *)
                                fun_error "Invalid selection. Please choose again."
                                sleep 2
                                ;;
                        esac
                    done
                    #Choose Primary Key ("Yes","No")
                    if [ "$pKey" == "no" ]; then
                        echo "Is it Primary Key?"
                        select isPkey in "Yes" "No"; do
                            case $isPkey in
                                "Yes")
                                    isPkey="yes"
                                    pKey="yes"
                                    break
                                    ;;
                                "No")
                                    isPkey="no"
                                    break
                                    ;;
                                *)
                                    fun_error "Invalid selection. Please choose again."
                                    sleep 2
                                    ;;
                            esac
                        done
                    else
                        isPkey="no"
                        #fun_success "There is already a primary key column"
                    fi
                    #Add the column name in a variable called metaName
                    if [ $i == $columnCount ]; then
                        metaName+="$columnName"
                    else
                        metaName+="${columnName}:"
                    fi
                    #Add Primary Key type in a variable called metaType
                    if [ $i == $columnCount ]; then
                        metaType+="$type"
                    else
                        metaType+="${type}:"
                    fi
                    #Add the column type in a variable called metaPK
                    if [ $i == $columnCount ]; then
                        metaPK+="$isPkey"
                    else
                        metaPK+="${isPkey}:"
                    fi
                else
                    #Invalid Cloumn Name
                    fun_error "Invalid input. Please enter a valid Cloumn Name."
                    sleep 2
                    clear
                    fun_create_table
                fi   
            done   
            touch "./${tableName}_data" "./${tableName}_metadata"
            echo "$metaName" >> "./${tableName}_metadata"
            echo "$metaType" >> "./${tableName}_metadata"
            echo "$metaPK" >> "./${tableName}_metadata"
            fun_success "Table created successfully..."
            sleep 5
            clear
            fun_table_menu
        else
            #Invalid Number
            fun_error "Invalid input. Please enter a valid Columns Count."
            sleep 2
            clear
            fun_create_table
        fi

    else
        #Invalid Name
        fun_error "Invalid input. Please enter a valid table name."
        sleep 2
        clear
        fun_create_table
    fi 
}



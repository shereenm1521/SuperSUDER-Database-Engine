#!/usr/bin/bash

delete_one_row() {
    fun_choose_table
    read -p "Enter the ID Number: " idNumber
    row=$(awk -F':' '$1=="'$idNumber'"' "./${current_table}_data") 
    if [ "$row" == "" ]; then
        fun_error "ID number does not exist"
        sleep 3
        clear
    else
        sed -i "/^$idNumber:/d" "./${current_table}_data"
        fun_success "The row with ID \"$idNumber\" has been deleted."
        sleep 3
        clear
    fi
}


delete_multi_row() {
    fun_choose_table
    read -p "Enter the first ID Number: " first_ID_Number
    read -p "Enter the last ID Number: " last_ID_Number
    fRow=$(awk -F':' '$1=="'$first_ID_Number'"' "./${current_table}_data")
    lRow=$(awk -F':' '$1=="'$last_ID_Number'"' "./${current_table}_data")

    if [ "$first_ID_Number" == "" ] || [ "$last_ID_Number" == "" ]; then
        fun_error "ID number does not exist"
        sleep 3
        clear
    else
        sed -i "/^$first_ID_Number:/,/^$last_ID_Number:/d" "./${current_table}_data"
        fun_success "The rows between ID \"$first_ID_Number\" and \"$last_ID_Number\" have been deleted."
        sleep 3
        clear
    fi
}


fun_delete_from_table() {

    select option in "One Row" "Multi Rows" "All Rows"; do
        case $option in
            "One Row")
                delete_one_row
                fun_table_menu
                ;;
            "Multi Rows")
                delete_multi_row
                fun_table_menu
                ;;
            "All Rows")
                echo -n "" > "./${current_table}_data"
                fun_success "the rows have been deleted..."
                sleep 3
                clear
                fun_table_menu
                ;;
            *)
                fun_error "Invalid selection. Please choose again."
                sleep 3
                clear
                fun_table_menu
                ;;
        esac
    done
}



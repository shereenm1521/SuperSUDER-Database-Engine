#!/usr/bin/bash
source ./Error_Style.sh
source ./Header_Note.sh
source ./Create_Database.sh
source ./Validate_Name.sh
source ./Validate_Numbers.sh
source ./List_Databases.sh
source ./Drop_Database.sh
source ./Connect_To_Database.sh
source ./Create_Table.sh
source ./List_Tables.sh
source ./Drop_Tables.sh
source ./Insert_Table.sh
source ./Update_Table.sh
source ./Select_Table.sh
source ./Delete_Table.sh
source ./Success_Style.sh
source ./Empty_Databases.sh
source ./Empty_Tables.sh

#============================================================ Functions ==================================================================

function fun_super_menu {

    echo "╔══════════════════════════════════╗"
    echo "║           Super Menu             ║"
    echo "╠════════╦═════════════════════════╣"
    echo "║ Option ║     Description         ║"
    echo "╠════════╬═════════════════════════╣"
    echo "║   1    ║ Create Database         ║"
    echo "║   2    ║ List Databases          ║"
    echo "║   3    ║ Drop Database           ║"
    echo "║   4    ║ Connect To Databases    ║"
    echo "║   5    ║ exit                    ║"
    echo "╚════════╩═════════════════════════╝"

    echo -e "Enter Choice: \c"
    read smenu
    case $smenu in
        1) fun_create_database      ;;
        2) fun_list_databases       ;;
        3) fun_drop_database        ;;
        4) fun_connect_to_databases ;;
        5) exit                     ;;
        *) 
        clear
        fun_header_note
        fun_error "Error: *** Wrong Choice *** "
        fun_super_menu
    esac
}

function fun_table_menu {
    
    echo "╔══════════════════════════════════╗"
    echo "║          Table Menu              ║"
    echo "╠════════╦═════════════════════════╣"
    echo "║ Option ║     Description         ║"
    echo "╠════════╬═════════════════════════╣"
    echo "║   1    ║ Create table            ║"
    echo "║   2    ║ List tables             ║"
    echo "║   3    ║ Drop table              ║"
    echo "║   4    ║ Select from table       ║"
    echo "║   5    ║ Delete from table       ║"
    echo "║   6    ║ Update table            ║"
    echo "║   7    ║ Insert into Table       ║"
    echo "║   8    ║ Back to Super Menu      ║"
    echo "║   9    ║ Exit                    ║"
    echo "╚════════╩═════════════════════════╝"

    echo -e "Enter Choice: \c"
    read smenu
    case $smenu in
        1) fun_create_table      ;;
        2) fun_list_tables       ;;
        3) fun_drop_table        ;;
        4) fun_Select_from_table ;;
        5) fun_delete_from_table ;;
        6) fun_update_table      ;;
        7) fun_insert_table      ;;
        8) 
        cd ../..        
        clear                 
        fun_header_note 
        fun_super_menu           ;;
        9) exit                  ;;
        *)
        clear
        cd ../.. 
        fun_header_note
        fun_error "Error: *** Wrong Choice *** "
        fun_super_menu
    esac
}
#============================================================ Starting ============================================================================

clear
PS2="SuperSUDER >> "
PS3="SuperSUDER >> "
fun_header_note
fun_super_menu




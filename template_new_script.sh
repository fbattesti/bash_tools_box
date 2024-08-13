#!/bin/bash

WORKDIR=$(pwd)
DEBUG=true

set -e
set -o errtrace
trap 'handle_error ${LINENO} "${BASH_LINENO[*]}" "${BASH_SOURCE[*]}" "${BASH_COMMAND}" "${FUNCNAME[*]:-empty}"' ERR
trap 'clean_workdir' EXIT


function handle_error() {
    local last_exit_code=$?
    local line_number=$1
    local bash_lineno=$2
    local bash_source=$3
    local bash_command=$4
    local func_name=${5:-empty}

    if [ $last_exit_code -ne 0 ]; then
        echo "---------------------------"
        echo "An error occurred. Exiting."
        echo "- Function: $func_name"
        echo "- Line: $line_number"
        echo "- File: $bash_source"
        echo "- Command: $bash_command"
        echo "- Exit Code: $last_exit_code"

        # Log the error to a file
        echo "$(date) - Error in function $func_name at line $line_number in file $bash_source: command '$bash_command' exited with status $last_exit_code" >> error.log

        echo "---------------------------"
        if [[ $DEBUG == false ]] ; then
            exit $last_exit_code
        fi
    fi
}



function clean_workdir(){
  # Clean function for delete temp in $WORKDIR file when the script end 
}


function debug_echo(){
    message=$1
    if [[ $DEBUG == "true" ]] ; then 
        echo ""
        echo "*** Function:${FUNCNAME[1]} --> ${message} ***"
        echo ""
    fi
}




main(){
  

}
main $@


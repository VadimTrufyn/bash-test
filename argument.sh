!#/bin/bash
show_help(){
    echo "use $0 -h -v -b" 
}

while getopts "h" opt; do
    case ${opt} in
        h )
            show_help
            echo "$OPTARG
            exit 0
        ;;

    esac
done 

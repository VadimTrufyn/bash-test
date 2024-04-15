#!/bin/bash

show_help(){
    echo "Use $0 -d for base name directories 
    -c numbers of directories
    -p permissions
    -f base name of files in each directories
    -fc numbers of files" 
}

creating_files(){
    for i in $(seq 1 $c); do
        dir_name="$d${i}"
        if [ -d "$dir_name"];then
            echo "such dir exist already"
            show_help
            exit 0 
        else
            mkdir "$dir_name"
            chmod 700 "$dir_name"
            for x in $(seq 1 $n); do
                file_name="$dir_name/$f$x"
                touch "$file_name"
                chmod "$p" "$file_name"
            done
        fi
    done
}

#default values
d="my-dir"
c=1
p=700
f="file"
n=1

#parse arguments using getopts and rewriting values
while getopts "hd:c:p:f:fc:" opt; do
    case ${opt} in
        h )
            show_help
            exit 0
        ;;
        d )
            d="$OPTARG"
        ;;
        c )
            c="$OPTARG"
        ;;
        p )
            p="$OPTARG"
        ;;
        f )
            f="$OPTARG"
        ;;
        n )
            n="$OPTARG"
        ;;
    esac
done 

creating_files

#!/bin/bash


# Function to display script usage
show_help(){
    echo "This script creates a backup for specified directories."
    echo "Usage: $0 -s source directory (default is $source) -p how often to rotate backups"
    exit 1
}


# Default values
dest="/var/backup_log"
source="/var/log/"
period=7


# Parsing command line options
while getopts "hs:d:p:" opt; do
    case ${opt} in
        h )
            show_help
            exit 0
            ;;
        d )
            dest="$OPTARG"
            ;;
        s )
            source="$OPTARG"
            ;;
        p )
            period="$OPTARG"
            if ! [[ $period =~ ^[0-9]+$ ]]; then
                echo "Error: Period must be a number."
                show_help
                exit 1
            fi
            ;;
        /? )
            show_help
            ;;
    esac
done 


# Function to create backup archives
backup(){
    for file in "$source"/*; do
        file_name=$(basename "$file")
        file_name="${file_name}$(date +"%Y-%m-%d")"
        tar -czf "${dest}/${file_name}.tar.gz" "$file"
    done
    echo "$(date +"%Y-%m-%d")"
    echo "New backup archives created in $dest"
}


# Function to rotate old backup archives
rotate_backup(){
    find "$dest" -type f -name "*.tar.gz" -mtime +${period} -exec rm {} \;
    echo "Old backup archives rotated in $dest"
}


# Check if destination directory exists for backup archives
if [ ! -d "$dest" ]; then
    echo "$dest does not exist"
    echo "Creating $dest"
    mkdir -p "$dest"
else
    rotate_backup
fi


# Check if source directory exists for backup
if [ ! -d "$source" ]; then
    echo "Error: $source does not exist"
    show_help
    exit 1
fi
# Call function to create backup archives
conflict here

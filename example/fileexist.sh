#!/usr/bin/env bash
set -Eeuo pipefail

# echo "enter target path and filename"
# read targetpath
# read filename
# if [[ -e "${targetpath}/${filename}" ]]; then
#     echo "file exist"
# else
#     echo "file not exist"
# fi

if [[ -e "$1/$2" ]]; then
    echo "file exist"
else
    echo "file not exist"
fi
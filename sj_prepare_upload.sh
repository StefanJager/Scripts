#!/bin/sh

# sj_prepare_upload.sh
# Copyright (C) 2017 Stefan Jager

# Renames and moves all image files based on their exif creation date.
# After the script finished, files can be found in the target directory under 
# YYYY-MM-DD/YYYY-MM-DD_HHmmSS(-<counter>).<extension>, where extension is the 
# original file extension and counter is only used if there are multiple files
# with the same timestamp.
#
# Prerequisites:
# - Relies on 'exiftool' to do the hard work, so that has to be installed.
# - Target directory has to exist before script is called.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



function echo_error_and_exit() {
    echo "----ERROR----"
    echo "$1"
    echo "-------------"
    exit 1
}

# Check if exiftool is installed.
which -s exiftool
WHICH_RESULT=$?
if [ $WHICH_RESULT -ne 0  ] ; then
    echo_error_and_exit "exiftool is needed for the script to work properly."
fi

# Check if there is the correct amount or parameters.
if [ "$#" -ne 2 ] ; then 
    echo_error_and_exit "Expected paths to work on as parameters."
fi

SOURCE_DIR="$1"
TARGET_DIR="$2"

# Check if $SOURCE_DIR is indeed a directory.
if [ ! -d "$SOURCE_DIR" ] ; then
    echo_error_and_exit "Expected first parameter to be the source directory."
fi

# Check if $TARGET_DIR is indeed a directory.
if [ ! -d "$TARGET_DIR" ] ; then
    echo_error_and_exit "Expected second parameter to be the target directory."
fi

# Go to specified directory.
cd "$SOURCE_DIR"

# Define directory name to sort the images into.
SORT_DIR="Sorted"

# Rename all image files to have their creation Date as name.
# Also move them into directories with the name $SORT_DIR/yyyy-mm-dd.
exiftool -r -d "$SORT_DIR"/%Y-%m-%d/%Y-%m-%d_%H%M%S%%-c.%%e "-filename<CreateDate" .

cd ./"$SORT_DIR"

for folder in *
do
	if [ -d "$folder" ]
	then
	    mv "$folder" "$TARGET_DIR"
	else
	    echo "$folder is no folder."
	fi
done

cd ..
rm -d $SORT_DIR

#!/bin/bash

# sj_exifcopy.sh
# Copyright (C) 2017 Stefan Jager

# Copies all exif data from ARW image files in a directory to jpg files in the same directory.
# Prerequisites:
# - Relies on 'exiftool' to do the hard work, so that has to be installed.
# - ARW files and jpg files have to have the same name (except for their extension).

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
if [ $WHICH_RESULT -ne 0 ] ; then
    echo_error_and_exit "exiftool is needed for this script to work properly."
fi

# Check if there is the correct amount of parameters.
if [ "$#" -ne 1 ] ; then
    echo_error_and_exit "Expected path to work on as a parameter."
fi

WORKING_DIR="$1"

# Check if passed in parameter leads to a directory.
if [ ! -d  "$WORKING_DIR" ] ; then
    echo_error_and_exit "Expected parameter to be a directory."
fi

# Go to specified directory.
cd "$WORKING_DIR"

for file in *.ARW
do
    length=${#file}
    basename=${file:0:$length-4}
    outputName=$basename".jpg"
    if [ -f $outputName ]
    then
        exiftool -overwrite_original -TagsFromFile $file $outputName
    else
	echo "$outputName not found."
    fi
done

#!/usr/local/bin/bash
######################################################################
#
# Script to backup video from cameras in Computer Science Department.
#
# Written By: Kyle Ricks
#
######################################################################

# Steps
# 0) Arguments
# 1) Check for all files to be avi
# 2) Delete non-avi
# 3) Create Archvie File
# 4) Add all avi to the Archive File
# 5) Move Archive File

######################################################################
#
# Arguments
#
######################################################################

video_dir=$1
DATE=$(date "+%Y-%m-%d")

archivefile=video_archive.${DATE}.tar

# Delete all .jpg
echo "Deleting all .jpg files in" $video_dir
find $video_dir -iname \*.jpg -exec /bin/rm {} \;

# Create Archive
echo "Creating" $archivefile
touch $video_dir/start.txt
tar --create --preserve-permissions --file=$video_dir/$archivefile $video_dir/start.txt -exec /bin/rm $video_dir/start.txt

# Append files to the archive
echo "Adding video files to" $archivefile
find $video_dir \( -iname "*.avi" -o -iname "*.mpg" \) -exec tar --remove-files $archivefile --append --file=$video_dir/$archivefile {} \;

# Bzip2 the Tar File
echo "Compressing" $archivefile "with Bzip2.  This will take some time."
bzip2 $video_dir/$archivefile

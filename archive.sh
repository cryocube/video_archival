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
# 1) Create Log File 
# 2) Delete *.jpg files
# 3) Create Archive File
# 4) Add all files older than 90 days to Archive; then delete them inline
# 5) Compress tar file with Bzip2
# 6) Move completed *.bz2 to transfer directory

######################################################################
#
# Arguments
#
######################################################################

video_dir=storage
log_dir=$video_dir/script_log
transfer_dir=$video_dir/compressed_archives
DATE=$(date "+%Y-%m-%d")
archivefile=video_archive.${DATE}.tar
log_file=${DATE}.log

######################################################################
#
# Main
#
######################################################################mv

# Create Log File
echo "Archive Script beginning" $DATE | tee $log_dir/$log_file
echo "Creating Log File" $log_file | tee -a $log_dir/$log_file

# Delete all .jpg
echo "Deleting all .jpg files in" $video_dir | tee -a $log_dir/$log_file
find $video_dir -name "*.jpg" -delete

# Create Archive
echo "Creating" $archivefile | tee -a $log_dir/$log_file
touch $video_dir/start.txt
tar -cf $video_dir/$archivefile $video_dir/start.txt && /bin/rm $video_dir/start.txt

# Append files to the archive
echo "Adding video files to" $archivefile | tee -a $log_dir/$log_file
find $video_dir -type f -mtime +90 -exec /usr/bin/tar -rf $video_dir/$archivefile {} \; -exec /bin/rm {} \;

# Bzip2 the Tar File
echo "Compressing" $archivefile "with Bzip2.  This will take some time." | tee -a $log_dir/$log_file
bzip2 -9 $video_dir/$archivefile

# Move completed .bz2 to transfer directory
echo "Moving" ${archivefile}.bz2 "to" $transfer_dir | tee -a $log_dir/$log_file
mv $video_dir/${archivefile}.bz2 $transfer_dir

# Program end - Terminate Log File
echo "Script completed" | tee -a $log_dir/$log_file


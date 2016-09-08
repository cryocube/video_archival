#!/usr/local/bin/bash
######################################################################
#
# Script to backup video from cameras in Computer Science Department.
#
# Written By: Kyle Ricks
# Updated   : 20160908
#
######################################################################

# Steps
# 0) Arguments
# 1) Create Log File 
# 2) Delete *.jpg files
# 3) Create Manifest of Archive Candidates
# 3) Create Archive File from Archive Candidates file 
# 4) Delete the Candidates
# 5) Compress tar file with Bzip2
# 6) Move completed *.bz2 to transfer directory

######################################################################
#
# Arguments
#
######################################################################

video_dir=/storage
log_dir=$video_dir/script_log
transfer_dir=$video_dir/compressed_archives
DATE=$(date "+%Y-%m-%d")
archivefile=video_archive.${DATE}.tar
log_file=${DATE}.log
candidate_file=candidate_file_${DATE}.txt

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

# Create File of Archive Candidates
echo "Creating Archive Candidates File" | tee -a $log_dir/$log_file
find $video_dir -type f -mtime +30 | tee -a $log_dir/$candidate_file

# Create Archive
echo "Creating" $archivefile | tee -a $log_dir/$log_file 
tar -cf $video_dir/$archivefile -T $log_dir/$candidate_file

# Delete the candidates
#echo "Deleting Candidates from" $candidate_file  | tee -a $log_dir/$log_file
#xargs rm < $candidate_file

# Bzip2 the Tar File
echo "Compressing" $archivefile "with Bzip2.  This will take some time." | tee -a $log_dir/$log_file
bzip2 -9 $video_dir/$archivefile

# Move completed .bz2 to transfer directory
echo "Moving" ${archivefile}.bz2 "to" $transfer_dir | tee -a $log_dir/$log_file
mv $video_dir/${archivefile}.bz2 $transfer_dir

# Program end - Terminate Log File
echo "Script completed" | tee -a $log_dir/$log_file

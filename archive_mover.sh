#!/usr/local/bin/zsh
######################################################################
#
# Script to move backup video files, compress, from 
# dvr.cs.wwu.edu to fs1.cs.wwu.edu in Computer Science Department.
#
# Written By: Kyle Ricks
# Updated   : 20161010
#
######################################################################

# Steps
# 0) Arguments
# 1) Create Log File
# 2) Move bzip2 files

######################################################################
#
# Arguments
#
######################################################################

destination=/export/dept/Support/video_archive
archive_source=/storage/compressed_archives
filetype=.txt
DATE=$(date "+%Y-%m-%d")
log_dir=/export/dept/Support/video_archive/logs
log_file=video_archive_download_${DATE}.log
ssh_id=/home/backup/.ssh/id_ed25519_dvr_backup
remote_user=backup
remote_sys=dvr.cams.cs.wuu.edu
remote_port=1022

######################################################################
#
# Main
#
######################################################################

#Create Log File
echo "["$(date +%H:%M:%S)"] Video Archive Download beginning" $DATE | tee $log_dir/$log_file
echo "["$(date +%H:%M:%S)"] Creating Log File" $log_file | tee -a $log_dir/$log_file

#Move bzip2 files
echo "["$(date +%H:%M:%S)"] SSHing to dvr server and downloading all" $filetype "files." | tee -a $log_dir/$log_file
#scp -i $ssh_id -P $remote_port $remote_user@$remote_sys:$archive_source/*$filetype $destination | tee -a $log_dir/$log_file

# Program end - Terminate Log File
echo "["$(date +%H:%M:%S)"] Script completed" | tee -a $log_dir/$log_file

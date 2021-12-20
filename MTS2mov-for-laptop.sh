#!/bin/bash

# MTS2mov-for-laptop.sh script
# (C) nabster
# Distribute under GPL
#
# Creates 7,000 kbps mov files for editing on the laptop.
# The final rendering is done on the desktop using
# 55,000 kbps files.
#
echo "Making for-laptop directory"
mkdir for-laptop
#
# -> Start loop
for files in `ls *.MTS`
do
#
# file extension truncation for later in script
filenamewithoutextension=${files%.MTS}
#
echo Converting $filenamewithoutextension
# As of 2012-07-29, -b has to be -b:v for video, and -deinterlace is replaced with -filter:v yadif
# As of 2013-10-10, xvid should be replaced with libxvid on debian
nice ffmpeg -i $files -acodec pcm_s16be -vcodec libxvid -b:v 7000k -filter:v yadif -s 1920x1080 -r 50 -y for-laptop/$filenamewithoutextension-1920p50.mov
#
# make a little thumbnail at 0.1 seconds
# nice ffmpeg -i $files -vframes 1 -ss 0.1 -s 384x216 for-laptop/$filenamewithoutextension.jpg
# link back for easy switching to proxy files
ln -sf for-laptop/$filenamewithoutextension-1920p50.mov .
#
done
# End loop <-
#
chmod og+rw *
#
# do some updates then shut down
# aptitude update
# aptitude -y safe-upgrade
updatedb
echo "shutting down..."
shutdown -h 20

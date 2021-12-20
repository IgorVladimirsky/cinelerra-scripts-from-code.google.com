#!/bin/bash

# mts2mov.sh script
# (C) nabster
# Distribute under GPL
#
# Creates cinelerra-compatible mov files 
# from all the .MTS files in the current directory.
# Works with files from the panasonic hdc-hs100.
# 
# Usage: MTS2mov.sh
# Comment or uncomment lines in the "nice ffmpeg ..."  as required.
#
# Make directory
echo "Making for-desktop directory for those who don't already use my directory structure"
mkdir -pv for-desktop
#
# -> Start loop
for files in `ls *.MTS`
do
#
# file extension truncation for later in script
filenamewithoutextension=${files%.MTS}
#
echo Converting $filenamewithoutextension
#
# Video conversion
# I used to edit at 720p50 mov.
#nice ffmpeg -i $files -acodec pcm_s16be -sameq -qns 50 -nr 110 -b 55000k -deinterlace -s 1280x720 -r 50 -y $filenamewithoutextension-720p50.mov
# Now I edit at 1080p50 and convert the output to 1080i50 or 720p50.  This line with noise reduction takes longer to process.
# Noise reduction is faster if done with x264 encoding at a later stage, because that is multi-core
# and this mpeg2 encoding is done on a single core.
#nice ffmpeg -i $files -acodec pcm_s16be -sameq -qns 50 -nr 50 -b 55000k -deinterlace -s 1920x1080 -r 50 -y for-desktop/$filenamewithoutextension-1920p50.mov
# The current line does not do noise reduction and is faster
# As of 2012-07-29, -b has to be -b:v for video, and -deinterlace is replaced with -filter:v yadif
nice ffmpeg -i $files -acodec pcm_s16be -sameq                 -vcodec mpeg4 -b:v 57000k -filter:v yadif -s 1920x1080 -r 50 -y for-desktop/$filenamewithoutextension-1920p50.mov

# Make a little thumbnail at 0.1 seconds
# nice ffmpeg -i $files -vframes 1 -ss 0.1 -s 384x216 $filenamewithoutextension.jpg
#
# Link back for easy switching to proxy files
ln -sf for-desktop/$filenamewithoutextension-1920p50.mov .
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

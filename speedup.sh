#!/bin/bash

# Description: make time lapse video
# Usage: time-lapse.sh <source-video> <destination-file> <frames>
# Source Video: the video that you are wanting to speed up
# Destination File: the file where the video will be saved
# Frames: the number of frames to pull per second (lower is faster, 1 is fastest, entering original fps will give original speed)

# Modified from the original by Andrew Wells
# http://pr0gr4mm3r.com/linux/how-to-create-a-time-lapse-video-using-ffmpeg/
# Therefore need to redistribute under the 
# Attribution-Noncommercial-Share Alike 3.0 Unported Licence
# http://creativecommons.org/licenses/by-nc-sa/3.0/

# Create temporary directory
mkdir speedup_temp
# Pick out single frames at less than the original frame rate
nice ffmpeg -i $1 -r $3 -f image2 speedup_temp/%05d.png
# Construct another movie file at 50 frames per second
nice ffmpeg -r 50 -i speedup_temp/%05d.png -b 55000k -r 50 -y $2
#
# Remove temporary directory
rm -rf ./speedup_temp

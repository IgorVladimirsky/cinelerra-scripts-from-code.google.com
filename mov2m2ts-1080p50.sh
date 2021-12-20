# mov2m2ts.sh script
# Creates m2ts files for 1080p50 video
#
# (c) nabster
# Distribute under GPL
# http://code.google.com/p/cinelerra-scripts
#
# Usage:
# Needs tsMuxeR in the current directory
# 1. Using Cinelerra, generate wav, ac3 and 1080p50 mov files for your filmclip
# 2. Comment in or out required lines from this script
# 3. execute ./mov2m2ts.sh filenamewithoutextension
# 

# exit if no arguments
if [ "$1" = "" ]
then
 echo ""
 echo "Usage: $0 filenamewithoutextension"
 echo "Needs tsMuxeR in the current directory"
 echo "Using Cinelerra, generate wav, ac3 and 1080p50 mov files for your filmclip"
 echo "Will put m2ts file in ../output/m2ts_avchd_dvd"
 echo ""
 echo "Optional extras depending on what is commented out:"
 echo "-> dvd mpeg in ../output/mpeg/"
 echo "-> m2ts in ../output/m2ts_avchd_dvd/"
 echo "-> youtube mp4 in ../output/youtube/"
 echo "-> makes a stereo mp4 for PS3 testing via mediatomb in /mnt/ripshare/video/holiday-video/"
 exit
fi

# Cleanup
rm -rv ffmpeg2pass-0.log junk.h264 x264_2pass.log

# AVCHD at 1080p50.
nice ffmpeg -i $1.mov -s 1920x1080 -pass 1 -nr  0 -qns   0 -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -preset:v medium -b:v 11000k -bt 1000k -maxrate 17000k -bufsize 30000k -y -r 50 junk.h264
nice ffmpeg -i $1.mov -s 1920x1080 -pass 2 -nr 30 -qns 100 -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -preset:v medium -b:v 11000k -bt 1000k -maxrate 17000k -bufsize 30000k -y -r 50 $1.h264


# Autogenerate a new tsMuxeR meta file: remember to change fps= to match ffmpeg
# Some say don't use insertSEI, contSPS for PS3, but that doesn't seem to help me
rm $1.meta
echo "MUXOPT --no-pcr-on-video-pid --new-audio-pes --vbr  --vbv-len=500
V_MPEG4/ISO/AVC, \"$1.h264\", fps=50, insertSEI, contSPS
A_AC3, \"$1.ac3\", lang=eng
A_LPCM, \"$1.wav\", lang=eng" >> $1.meta

# Mux the m2ts file
./tsMuxeR $1.meta ../output/m2ts_avchd_dvd/$1.m2ts

# Cleanup
#
rm -rv ffmpeg2pass-0.log junk.h264 x264_2pass.log
chmod og+rw *

# Mux an MP4 for mediatomb
# echo Making an MP4 for mediatomb
# ffmpeg -i $1.ac3 -sameq -vn -acodec libfaac -ac 2 -ar 48000 -ab 320k -y $1.aac
# rm $1.mp4
# MP4Box -new $1.mp4 -add $1.h264 -add $1.aac -fps 50
# mv $1.mp4 /mnt/ripshare/video/holiday-video/

# Make a dvd mpeg whilst we're at it.
# http://cinelerra.org/docs/split_manual_en/cinelerra_cv_manual_en_20.html
# recommends -b 8600 for the video bitrate
# nice ffmpeg -i $1.ac3 -i $1.mov -aspect 16:9 -s 720x576 -b 8600k -maxrate 9050k -target pal-dvd -y ../output/mpeg/$1.mpeg

# If root, then I can do some updates and then shut down
# aptitude update
# aptitude -y safe-upgrade
# updatedb
# boot-game-os
# shutdown -h 20

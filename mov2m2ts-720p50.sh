# mov2m2ts.sh script
# Creates m2ts files for 720p50 video
#
# (c) nabster
# Distribute under GPL
# http://code.google.com/p/cinelerra-scripts
#
# Usage:
# Needs tsMuxeR in the current directory
# 1. Using Cinelerra, generate wav, ac3 and 720p50 mov files for your filmclip
# 2. Comment in or out required lines from this script
# 3. execute ./mov2m2ts.sh filenamewithoutextension
# 
# NB     
#        The Sony Playstation 3 
#        will accept 1920x1080 at 30 fps
#        will accept 1280x720 at 50 fps
#        will not accept 1920x1080 at 50fps

# exit if no arguments
if [ "$1" = "" ]
then
 echo ""
 echo "Usage: $0 filenamewithoutextension"
 echo "Needs tsMuxeR in the current directory"
 echo "Using Cinelerra, generate wav, ac3 and 720p50 mov files for your filmclip"
 echo "Will put m2ts file in ../output/m2ts"
 echo ""
 echo "Optional extras depending on what is commented out:"
 echo "-> dvd mpeg in ../output/mpeg/"
 echo "-> m2ts in ../output/m2ts/"
 echo "-> youtube mp4 in ../output/youtube/"
 echo "-> makes a stereo mp4 for PS3 testing via mediatomb in /mnt/ripshare/video/holiday-video/"
 exit
fi

# Cleanup
rm -rv ffmpeg2pass-0.log junk.h264 x264_2pass.log

# Blu-ray quality at 720p50 with 2 bidirectional frames. (I have found that -g needs to be 1 or 0 to play back on PS3, can anybody help?)
nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -vpre slower_firstpass -b 26000k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 junk.h264
nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -vpre slower           -b 26000k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 $1.h264

#
# Other potential ffmpeg lines:
#
# Blu-ray quality at 720p50 with 3 bidirectional frames. Three reference frames used to work in vlc and xine, and now it doesn't, so I can't test footage
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -vpre slower_firstpass -b 26000k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 3 -g 0 -threads 0 -y -r 50 junk.h264
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -vpre slower           -b 26000k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 3 -g 0 -threads 0 -y -r 50 $1.h264
#
# Lines for ffmpeg - 720p50 - AVCHD bitrate on DVD media is 18Mbps.  Auto threads, no keyframes!
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -vpre fastfirstpass -b 16000k -bt 1000k -maxrate 17000k -bufsize 20000k -g 0 -threads 0 -y -r 50 junk.h264
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -vpre hq            -b 16000k -bt 1000k -maxrate 17000k -bufsize 20000k -g 0 -threads 0 -y -r 50 $1.h264
#
# Single pass constant rate factor takes less time to encode:
# nice ffmpeg -r 50 -i $1.mov -vcodec libx264 -vpre normal -vpre main -crf 26 -r 50 -y $1.h264 
#
# These lines worked beautifully for 720p50 on ps3, but now mix up frames without specifying keyint (-g =1)
# nice ffmpeg -threads 0 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -vpre fastfirstpass -b 26000k -bt 26000k -maxrate 30000k -bufsize 78125k -y -r 50 junk.h264
# nice ffmpeg -threads 0 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -vpre hq            -b 26000k -bt 26000k -maxrate 30000k -bufsize 78125k -y -r 50 $1.h264
# 
# For 1920p30:
# nice ffmpeg -i $1.mov -s 1920x1080 -pass 1 -vcodec libx264 -vpre fastfirstpass -vpre main -b 23000k -bt 23000k -maxrate 41000k -y -r 25 junk.h264
# nice ffmpeg -i $1.mov -s 1920x1080 -pass 2 -vcodec libx264 -vpre hq            -vpre main -b 28000k -bt 28000k -maxrate 41000k -y -r 25 $1.h264
#
# For old ffmpeg:
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -b 24000k -bf 2 -coder 1 -trellis 1 -flags +loop -y -r 50 junk.h264
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -b 24000k -bf 2 -coder 1 -trellis 1 -flags +loop -y -r 50 $1.h264


# Autogenerate a new tsMuxeR meta file: remember to change fps= to match ffmpeg
# Some say don't use insertSEI, contSPS for PS3, but that doesn't seem to help me
rm $1.meta
echo "MUXOPT --no-pcr-on-video-pid --new-audio-pes --vbr  --vbv-len=500
V_MPEG4/ISO/AVC, \"$1.h264\", fps=50, insertSEI, contSPS
A_AC3, \"$1.ac3\", lang=eng
A_LPCM, \"$1.wav\", lang=eng" >> $1.meta

# Mux the m2ts file
./tsMuxeR $1.meta ../output/m2ts/$1.m2ts

# Cleanup
#
rm ffmpeg2pass-0.log junk.h264 x264_2pass.log
chmod og+rw *

# Mux an MP4 for mediatomb
echo Making an MP4 for mediatomb
ffmpeg -i $1.ac3 -sameq -vn -acodec libfaac -ac 2 -ar 48000 -ab 320k -y $1.aac
rm $1.mp4
MP4Box -new $1.mp4 -add $1.h264 -add $1.aac -fps 50
mv $1.mp4 /mnt/ripshare/video/holiday-video/

# Make a dvd mpeg whilst we're at it.
# http://cinelerra.org/docs/split_manual_en/cinelerra_cv_manual_en_20.html
# recommends -b 8600 for the video bitrate
nice ffmpeg -i $1.ac3 -i $1.mov -aspect 16:9 -s 720x576 -b 8600k -maxrate 9050k -target pal-dvd -y ../output/mpeg/$1.mpeg

# If root, then I can do some updates and then shut down
# aptitude update
# aptitude -y safe-upgrade
# updatedb
# boot-game-os
# shutdown -h 20

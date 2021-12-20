# make-standard-mpeg-for-dvd.sh script
# (C) nabster
# Distribute under GPL
#
# Creates DVD-compatible mpeg files 
# from all m2ts files in the current directory
# and puts the output in ../mpeg
# 
# Usage: make-standard-mpeg-for-dvd.sh
# 
# Change the bitrates using an online bitrate calculator
# http://dvd-hq.info/bitrate_calculator.php?length=59&vformat=PAL&audiobr=448&astreams=1&ratemode=Auto&motion=Heavy&scenedetect=Active&brlimit=9800&discsize=4482&otherassets=0#Calculator
# http://cinelerra.org/docs/split_manual_en/cinelerra_cv_manual_en_20.html
# recommends -b 8600 for the maximum video bitrate

# make target directory if it doesn't already exist
mkdir -pv ../mpeg

# -> Start loop
for files in `ls *.m2ts`
do

# file extension truncation for later in script
filenamewithoutextension=${files%.m2ts}

# ffmpeg single line conversion
nice ffmpeg -i $filenamewithoutextension.m2ts -aspect 16:9 -s 720x576 -b 8600k -maxrate 8600k -target pal-dvd -y ../mpeg/$filenamewithoutextension.mpeg

# The following block of code is something that I tried earlier
# to maximise motion and sound quality during conversion.
# It is ineffective and inefficient.  My next plan is to switch off 
# image stabilisation on the camcorder to try and have smooth
# panning.  The code is left it here for reference purposes only.
#
# echo _______________________________________________
# echo Converting $filenamewithoutextension
# echo -----------------------------------------------
# echo Audio conversion $filenamewithoutextension
# echo -----------------------------------------------
# nice ffmpeg -i $filenamewithoutextension.m2ts -ab 448k -ar 48000 -y $filenamewithoutextension.448k.ac3
# echo -----------------------------------------------
# echo yuv conversion $filenamewithoutextension
# echo -----------------------------------------------
# nice ffmpeg -i $filenamewithoutextension.m2ts -aspect 16:9 -s 720x576 -f yuv4mpegpipe -vcodec pgmyuv - | yuvmotionfps -r 50:1 > $filenamewithoutextension.yuv
# echo -----------------------------------------------
# echo echo mpeg2 conversion $filenamewithoutextension
# echo -----------------------------------------------
# nice ffmpeg -i $filenamewithoutextension.448k.ac3 -acodec copy -i $filenamewithoutextension.yuv -target pal-dvd -aspect 16:9 -b 9040k -maxrate 9050k -y ../standard-mpeg-for-dvd/$filenamewithoutextension.mpeg
# rm $filenamewithoutextension.yuv
# rm $filenamewithoutextension.448k.ac3

done
# End loop <-
#
chmod og+rw *
#

# Chain load next task - to make the dvd
cd ../standard-mpeg-for-dvd
./basic-dvdauthor-with-xml.sh
#
# do some updates then shut down
# aptitude update
# aptitude -y safe-upgrade
# updatedb
echo "shutting down..."
shutdown -h 20

# MOV2mov.sh script
# (C) nabster
# Distribute under GPL
#
# Creates cinelerra-compatible 720p50 mov files 
# from all the 640:480 aspect ratio .MOV files in 
# the current directory.
# 
# Usage: MOV2mov.sh
# Comment or uncomment lines in the "nice ffmpeg ..."  as required.
#
# -> Start loop
for files in `ls *.MOV`
do
#
# file extension truncation for later in script
filenamewithoutextension=${files%.MOV}
#
# write conversion log
echo "`date` Converting $filenamewithoutextion" >> conversion.log
echo 
#
echo Converting $filenamewithoutextension
#
# make a 720p50 mov
nice ffmpeg -i $files -acodec pcm_s16be -sameq -qns 10 -b 55000k -deinterlace -s 960x720 -r 50 -y $filenamewithoutextension-720p50.mov
#
# make a thumbnail at 0.1 seconds
nice ffmpeg -i $files -vframes 1 -ss 0.1 -s 960x720 $filenamewithoutextension.jpg
#
done
# End loop <-
#
chmod og+rw *
#
# do some updates then shut down
aptitude update
aptitude -y safe-upgrade
updatedb
echo "shutting down..."
shutdown -h 20

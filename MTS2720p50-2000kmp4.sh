echo "Just converts all .MTS files"

# -> Start loop
for files in `ls *.MTS`
do

filenamewithoutextension=${files%.MTS}
nice -n 15 ffmpeg -i $filenamewithoutextension.MTS -vcodec libx264 -preset fast -b 2000k -r 50 -s 1280x720 -acodec libfaac -ab 128k -ac 2 -sameq -pass 1 -f rawvideo -an -y /dev/null 
nice -n 15 ffmpeg -i $filenamewithoutextension.MTS -vcodec libx264 -preset fast -b 2000k -r 50 -s 1280x720 -acodec libfaac -ab 128k -ac 2 -sameq -pass 2 -y $filenamewithoutextension-720p50-2000k.mp4
rm ffmpeg2pass-0.log x264_2pass.log x264_2pass.log.mbtree
done
# End loop <-
#
chmod og+rw *
#

echo "shutting down..."
shutdown -h 20

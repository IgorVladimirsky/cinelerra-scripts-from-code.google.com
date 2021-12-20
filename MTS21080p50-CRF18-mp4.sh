echo "Just converts all .MTS files"

# -> Start loop
for files in `ls *.MTS`
do

filenamewithoutextension=${files%.MTS}
nice -n 15 ffmpeg -i $filenamewithoutextension.MTS -c:v libx264  -nr 30 -qns 100 -preset slower -profile:v high444 -r 50 -s 1920x1080 -filter:v yadif -c:a copy -y $filenamewithoutextension-10800p50-CRF18.mp4
rm ffmpeg2pass-0.log x264_2pass.log x264_2pass.log.mbtree ffmpeg2pass-0.log.mbtree
done
# End loop <-
#
chmod og+rw *
#

echo "shutting down..."
shutdown -h 20

echo "Just converts all .MTS files into dvd-compatible mpegs"
echo "Used to dump all camcorder footage into an un-edited DVD"


# -> Start loop
for files in `ls *.MTS`
do

# file extension truncation for later in script
filenamewithoutextension=${files%.MTS}

# ffmpeg single line conversion to DVD quality
nice ffmpeg -i $filenamewithoutextension.MTS -aspect 16:9 -s 720x576 -deinterlace -r 25 -target pal-dvd -acodec copy -y $filenamewithoutextension-dvd-quality-conversion.mpeg
rm ffmpeg2pass-0.log ffmpeg2pass-0.log.mbtree
done
# End loop <-
#
chmod og+rw *
#

echo "shutting down..."
shutdown -h 20

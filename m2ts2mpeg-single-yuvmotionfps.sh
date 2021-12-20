
# Converts m2ts to DVD-compatible mpeg's
# Modify bitrates after using an online calculator : http://dvd-hq.info/bitrate_calculator.php
# 
# Notes :
# -ab 128k, -b 6450k, -maxrate 9350k and -minrate 2550k gives about 1.5h on a 4.3Gb disk
# -ab 448k, -b 9050k, -maxrate 9050k and -minrate 9050k is pretty much max for DVD spec, and still gives > 60 min
# 

# (C) nabster
# Distribute under GPL

# Audio extract line
# Note: add in -map 0:2 -ac 2 to downsample to stereo
nice ffmpeg -i $1.m2ts -ab 448k -ar 48000 -y $1.448k.ac3

# Video extract line
nice ffmpeg -i $1.m2ts -aspect 16:9 -s 720x576 -f yuv4mpegpipe -vcodec pgmyuv - | yuvmotionfps -r 50:1 > $1.yuv

# Compress video and combine to output file
nice ffmpeg -i $1.448k.ac3 -acodec copy -i $1.yuv -target pal-dvd -aspect 16:9 -b 9050k -maxrate 9050k -minrate 9050k $1.mpeg
# rm $1.yuv
# rm $1.ac3

# Copy to output directory
mv $1.mpeg ../output/hq-dvd/$1.mpeg

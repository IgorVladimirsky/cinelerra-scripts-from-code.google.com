# (c) nabster
# Distribute under GPL
# http://nabstersblog.blogspot.com
#
# exit if no arguments
if [ "$1" = "" ]
then
 echo ""
 echo "Usage: $0 input-video-file-name-without-extension"
 exit
fi

nice ffmpeg -i $1.mp3 -i $1.mov -vcodec libx264 -vpre slow_firstpass -vpre baseline -b 2000k -r 25 -s 1280x720 -acodec libfaac -ab 128k -sameq -pass 1 -f rawvideo -an -y /dev/null 
nice ffmpeg -i $1.mp3 -i $1.mov -vcodec libx264 -vpre slow           -vpre baseline -b 2000k -r 25 -s 1280x720 -acodec libfaac -ab 128k -ac 2 -sameq -pass 2 -y ../output/youtube/$1-youtubeHD.mp4
rm ffmpeg2pass-0.log junk.h264 x264_2pass.log


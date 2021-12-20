# (c) nabster
# Distribute under GPL
# http://nabstersblog.blogspot.com
#
# exit if no arguments
if [ "$1" = "" ]
then
 echo ""
 echo "Usage: $0 input-video-file-name-with-extension"
 echo "Makes an 800x480 h264 file compatible with android and HTC blackstone"
 echo "13 frames per second, video bitrate 480k"
 exit
fi

nice ffmpeg -i $1.mp3 -i $1.mov -vcodec libx264 -vpre slow_firstpass -vpre baseline -b 480k -r 13 -s 800x480 -acodec libfaac -ab 128k -sameq -pass 1 -f rawvideo -an -y /dev/null  &&  nice ffmpeg -i $1.mp3 -i $1.mov -vcodec libx264 -vpre slow -vpre baseline -b 480k -r 13 -s 800x480 -acodec libfaac -ab 128k -ac 2 -sameq -pass 2 $1-tabletphone.mp4


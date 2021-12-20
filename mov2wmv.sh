#
# Reference
# http://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/WMV

echo "Usage filenamewithoutextension"
echo "Needs .mov and .mp3 files in current directory"
echo "The mov has to be without sound,"
echo "because the encoder can't handle surround sound"

nice ffmpeg -i $1.mp3 -i $1.mov -b 6600k -vcodec wmv2 -ab 320k -y $1.wmv

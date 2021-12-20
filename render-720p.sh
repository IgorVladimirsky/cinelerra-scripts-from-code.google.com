# (C) nabster
# Distribute under GPL
# http://code.google.com/p/cinelerra-scripts

# exit if no arguments
if [ "$1" = "" ]
then
 echo "
 Renders 720p50 movie files from my 1920p50 cinelerra xml files.
 
 If you've been editing on another machine, then you might need 
 to manually load your xml file into cinelerrra once so that it
 creates its index files.
 
 Usage: $0 cinelerra-xml-file.xml
 
 or to render all xml files in the current directory:
 for i in \`ls *.xml\`; do $0 \$i; done
 
 "
 exit
fi

#
echo "
 `date --rfc-3339=seconds` Making directories for people who don't already use my structure..."
mkdir -pv ../output/mpeg
mkdir -pv ../output/m2ts_bluray
mkdir -pv ../output/m2ts_avchd_dvd
mkdir -pv ../output/youtube
mkdir -pv ../output/mp4

# 
echo "
 `date --rfc-3339=seconds` Deriving truncated filenames and paths..."
files=$1
filenamewithoutextension=${files%.xml}
echo "File name without .xml extension = $filenamewithoutextension"
filenamewithfullpath=`ls -1 $1 | awk  -vpath=$PWD/ '{print path$1}'`
filenamewithfullpathwithoutextension=${filenamewithfullpath%.xml}
echo "File name with full path, without extension = $filenamewithfullpathwithoutextension"

# Say which file we are working on
echo " $filenamewithoutextension"
echo " ========================="


# In bash, subroutines are called functions and are defined by () after
# the intended function name.
# Functions must be declared before they can be called.


#
# The following subroutine 
# -creates the cinelerra renderlist
# -renders mov, wav, ac3 and mp3 files
render_raw_audiovideo()
{
# This first part makes the renderlist
echo "
 `date --rfc-3339=seconds` Making renderlist..."
rm -fv $1.renderlist
echo "<?xml version=\"1.0\"?>
<JOB EDL_PATH=\"$filenamewithfullpathwithoutextension.xml\" STRATEGY=\"0\" ENABLED=\"1\" ELAPSED=\"0\">
<ASSET SRC=\"$filenamewithfullpathwithoutextension.wav\">
<FOLDER>Media</FOLDER>
<FORMAT TYPE=\"Microsoft WAV\" USE_HEADER=\"1\"></FORMAT>
<AUDIO CHANNELS=\"0\" RATE=\"0\" BITS=\"16\" BYTE_ORDER=\"1\" SIGNED=\"1\" HEADER=\"0\" DITHER=\"0\" ACODEC=\"twos\" AUDIO_LENGTH=\"0\"></AUDIO>
<VIDEO_OMIT HEIGHT=\"0\" WIDTH=\"0\" LAYERS=\"0\" FRAMERATE=\"0\" VCODEC=\"yuv2\" VIDEO_LENGTH=\"0\" INTERLACE_AUTOFIX=\"1\" INTERLACE_MODE=\"UNKNOWN\" INTERLACE_FIXMETHOD=\"SHIFT_UPONE\" REEL_NAME=\"cin0000\" REEL_NUMBER=\"0\" TCSTART=\"0\" TCEND=\"0\" TCFORMAT=\"0\"></VIDEO_OMIT>
</ASSET>
PATH $filenamewithfullpathwithoutextension.wav
AUDIO_CODEC twos
VIDEO_CODEC yuv2
AMPEG_BITRATE 320
AMPEG_DERIVATIVE 3
VORBIS_VBR 0
VORBIS_MIN_BITRATE -1
VORBIS_BITRATE 128000
VORBIS_MAX_BITRATE -1
THEORA_FIX_BITRATE 1
THEORA_BITRATE 860000
THEORA_QUALITY 16
THEORA_SHARPNESS 2
THEORA_KEYFRAME_FREQUENCY 64
THEORA_FORCE_KEYFRAME_FEQUENCY 64
MP3_BITRATE 256000
MP4A_BITRATE 256000
MP4A_QUANTQUAL 100
JPEG_QUALITY 100
ASPECT_RATIO -1.0000000000000000e+00
VMPEG_IFRAME_DISTANCE 45
VMPEG_PFRAME_DISTANCE 0
VMPEG_PROGRESSIVE 0
VMPEG_DENOISE 1
VMPEG_BITRATE 1000000
VMPEG_DERIVATIVE 1
VMPEG_QUANTIZATION 15
VMPEG_CMODEL 0
VMPEG_FIX_BITRATE 0
VMPEG_SEQ_CODES 0
VMPEG_PRESET 0
VMPEG_FIELD_ORDER 0
H264_BITRATE 2000000
H264_QUANTIZER 5
H264_FIX_BITRATE 0
DIVX_BITRATE 2000000
DIVX_RC_PERIOD 50
DIVX_RC_REACTION_RATIO 45
DIVX_RC_REACTION_PERIOD 10
DIVX_MAX_KEY_INTERVAL 250
DIVX_MAX_QUANTIZER 31
DIVX_MIN_QUANTIZER 1
DIVX_QUANTIZER 5
DIVX_QUALITY 5
DIVX_FIX_BITRATE 1
DIVX_USE_DEBLOCKING 1
MS_BITRATE 1000000
MS_BITRATE_TOLERANCE 500000
MS_INTERLACED 0
MS_QUANTIZATION 10
MS_GOP_SIZE 45
MS_FIX_BITRATE 1
AC3_BITRATE 640
PNG_USE_ALPHA 0
EXR_USE_ALPHA 0
EXR_COMPRESSION 0
TIFF_CMODEL 0
TIFF_COMPRESSION 0
FORMAT_YUV_USE_PIPE 0
FORMAT_YUV_PIPE 
REEL_NAME cin0000
REEL_NUMBER 0
TCSTART 0
TCEND 0
TCFORMAT 0
</JOB>
<JOB EDL_PATH=\"$filenamewithfullpathwithoutextension.xml\" STRATEGY=\"0\" ENABLED=\"1\" ELAPSED=\"0\">
<ASSET SRC=\"$filenamewithfullpathwithoutextension.ac3\">
<FOLDER>Media</FOLDER>
<FORMAT TYPE=\"AC3\" USE_HEADER=\"1\"></FORMAT>
<AUDIO CHANNELS=\"0\" RATE=\"0\" BITS=\"16\" BYTE_ORDER=\"1\" SIGNED=\"1\" HEADER=\"0\" DITHER=\"0\" ACODEC=\"twos\" AUDIO_LENGTH=\"0\"></AUDIO>
<VIDEO_OMIT HEIGHT=\"0\" WIDTH=\"0\" LAYERS=\"0\" FRAMERATE=\"0\" VCODEC=\"yuv2\" VIDEO_LENGTH=\"0\" INTERLACE_AUTOFIX=\"1\" INTERLACE_MODE=\"UNKNOWN\" INTERLACE_FIXMETHOD=\"SHIFT_UPONE\" REEL_NAME=\"cin0000\" REEL_NUMBER=\"0\" TCSTART=\"0\" TCEND=\"0\" TCFORMAT=\"0\"></VIDEO_OMIT>
</ASSET>
PATH $filenamewithfullpathwithoutextension.ac3
AUDIO_CODEC twos
VIDEO_CODEC yuv2
AMPEG_BITRATE 320
AMPEG_DERIVATIVE 3
VORBIS_VBR 0
VORBIS_MIN_BITRATE -1
VORBIS_BITRATE 128000
VORBIS_MAX_BITRATE -1
THEORA_FIX_BITRATE 1
THEORA_BITRATE 860000
THEORA_QUALITY 16
THEORA_SHARPNESS 2
THEORA_KEYFRAME_FREQUENCY 64
THEORA_FORCE_KEYFRAME_FEQUENCY 64
MP3_BITRATE 256000
MP4A_BITRATE 256000
MP4A_QUANTQUAL 100
JPEG_QUALITY 100
ASPECT_RATIO -1.0000000000000000e+00
VMPEG_IFRAME_DISTANCE 45
VMPEG_PFRAME_DISTANCE 0
VMPEG_PROGRESSIVE 0
VMPEG_DENOISE 1
VMPEG_BITRATE 1000000
VMPEG_DERIVATIVE 1
VMPEG_QUANTIZATION 15
VMPEG_CMODEL 0
VMPEG_FIX_BITRATE 0
VMPEG_SEQ_CODES 0
VMPEG_PRESET 0
VMPEG_FIELD_ORDER 0
H264_BITRATE 2000000
H264_QUANTIZER 5
H264_FIX_BITRATE 0
DIVX_BITRATE 2000000
DIVX_RC_PERIOD 50
DIVX_RC_REACTION_RATIO 45
DIVX_RC_REACTION_PERIOD 10
DIVX_MAX_KEY_INTERVAL 250
DIVX_MAX_QUANTIZER 31
DIVX_MIN_QUANTIZER 1
DIVX_QUANTIZER 5
DIVX_QUALITY 5
DIVX_FIX_BITRATE 1
DIVX_USE_DEBLOCKING 1
MS_BITRATE 1000000
MS_BITRATE_TOLERANCE 500000
MS_INTERLACED 0
MS_QUANTIZATION 10
MS_GOP_SIZE 45
MS_FIX_BITRATE 1
AC3_BITRATE 640
PNG_USE_ALPHA 0
EXR_USE_ALPHA 0
EXR_COMPRESSION 0
TIFF_CMODEL 0
TIFF_COMPRESSION 0
FORMAT_YUV_USE_PIPE 0
FORMAT_YUV_PIPE 
REEL_NAME cin0000
REEL_NUMBER 0
TCSTART 0
TCEND 0
TCFORMAT 0
</JOB>
<JOB EDL_PATH=\"$filenamewithfullpathwithoutextension.xml\" STRATEGY=\"0\" ENABLED=\"1\" ELAPSED=\"0\">
<ASSET SRC=\"$filenamewithfullpathwithoutextension.mp3\">
<FOLDER>Media</FOLDER>
<FORMAT TYPE=\"MPEG Audio\" USE_HEADER=\"1\"></FORMAT>
<AUDIO CHANNELS=\"0\" RATE=\"0\" BITS=\"16\" BYTE_ORDER=\"1\" SIGNED=\"1\" HEADER=\"0\" DITHER=\"0\" ACODEC=\"twos\" AUDIO_LENGTH=\"0\"></AUDIO>
<VIDEO_OMIT HEIGHT=\"0\" WIDTH=\"0\" LAYERS=\"0\" FRAMERATE=\"0\" VCODEC=\"yuv2\" VIDEO_LENGTH=\"0\" INTERLACE_AUTOFIX=\"1\" INTERLACE_MODE=\"UNKNOWN\" INTERLACE_FIXMETHOD=\"SHIFT_UPONE\" REEL_NAME=\"cin0000\" REEL_NUMBER=\"0\" TCSTART=\"0\" TCEND=\"0\" TCFORMAT=\"0\"></VIDEO_OMIT>
</ASSET>
PATH $filenamewithfullpathwithoutextension.mp3
AUDIO_CODEC twos
VIDEO_CODEC yuv2
AMPEG_BITRATE 320
AMPEG_DERIVATIVE 3
VORBIS_VBR 0
VORBIS_MIN_BITRATE -1
VORBIS_BITRATE 128000
VORBIS_MAX_BITRATE -1
THEORA_FIX_BITRATE 1
THEORA_BITRATE 860000
THEORA_QUALITY 16
THEORA_SHARPNESS 2
THEORA_KEYFRAME_FREQUENCY 64
THEORA_FORCE_KEYFRAME_FEQUENCY 64
MP3_BITRATE 256000
MP4A_BITRATE 256000
MP4A_QUANTQUAL 100
JPEG_QUALITY 100
ASPECT_RATIO -1.0000000000000000e+00
VMPEG_IFRAME_DISTANCE 45
VMPEG_PFRAME_DISTANCE 0
VMPEG_PROGRESSIVE 0
VMPEG_DENOISE 1
VMPEG_BITRATE 1000000
VMPEG_DERIVATIVE 1
VMPEG_QUANTIZATION 15
VMPEG_CMODEL 0
VMPEG_FIX_BITRATE 0
VMPEG_SEQ_CODES 0
VMPEG_PRESET 0
VMPEG_FIELD_ORDER 0
H264_BITRATE 2000000
H264_QUANTIZER 5
H264_FIX_BITRATE 0
DIVX_BITRATE 2000000
DIVX_RC_PERIOD 50
DIVX_RC_REACTION_RATIO 45
DIVX_RC_REACTION_PERIOD 10
DIVX_MAX_KEY_INTERVAL 250
DIVX_MAX_QUANTIZER 31
DIVX_MIN_QUANTIZER 1
DIVX_QUANTIZER 5
DIVX_QUALITY 5
DIVX_FIX_BITRATE 1
DIVX_USE_DEBLOCKING 1
MS_BITRATE 1000000
MS_BITRATE_TOLERANCE 500000
MS_INTERLACED 0
MS_QUANTIZATION 10
MS_GOP_SIZE 45
MS_FIX_BITRATE 1
AC3_BITRATE 640
PNG_USE_ALPHA 0
EXR_USE_ALPHA 0
EXR_COMPRESSION 0
TIFF_CMODEL 0
TIFF_COMPRESSION 0
FORMAT_YUV_USE_PIPE 0
FORMAT_YUV_PIPE 
REEL_NAME cin0000
REEL_NUMBER 0
TCSTART 0
TCEND 0
TCFORMAT 0
</JOB>
<JOB EDL_PATH=\"$filenamewithfullpathwithoutextension.xml\" STRATEGY=\"0\" ENABLED=\"1\" ELAPSED=\"0\">
<ASSET SRC=\"$filenamewithfullpathwithoutextension.mov\">
<FOLDER>Media</FOLDER>
<FORMAT TYPE=\"Quicktime for Linux\" USE_HEADER=\"1\"></FORMAT>
<AUDIO_OMIT CHANNELS=\"0\" RATE=\"0\" BITS=\"16\" BYTE_ORDER=\"1\" SIGNED=\"1\" HEADER=\"0\" DITHER=\"0\" ACODEC=\"twos\" AUDIO_LENGTH=\"0\"></AUDIO_OMIT>
<VIDEO HEIGHT=\"0\" WIDTH=\"0\" LAYERS=\"0\" FRAMERATE=\"0\" VCODEC=\"raw \" VIDEO_LENGTH=\"0\" INTERLACE_AUTOFIX=\"1\" INTERLACE_MODE=\"UNKNOWN\" INTERLACE_FIXMETHOD=\"SHIFT_UPONE\" REEL_NAME=\"cin0000\" REEL_NUMBER=\"0\" TCSTART=\"0\" TCEND=\"0\" TCFORMAT=\"0\"></VIDEO>
</ASSET>
PATH $filenamewithfullpathwithoutextension.mov
AUDIO_CODEC twos
VIDEO_CODEC raw 
AMPEG_BITRATE 320
AMPEG_DERIVATIVE 3
VORBIS_VBR 0
VORBIS_MIN_BITRATE -1
VORBIS_BITRATE 128000
VORBIS_MAX_BITRATE -1
THEORA_FIX_BITRATE 1
THEORA_BITRATE 860000
THEORA_QUALITY 16
THEORA_SHARPNESS 2
THEORA_KEYFRAME_FREQUENCY 64
THEORA_FORCE_KEYFRAME_FEQUENCY 64
MP3_BITRATE 256000
MP4A_BITRATE 256000
MP4A_QUANTQUAL 100
JPEG_QUALITY 100
ASPECT_RATIO -1.0000000000000000e+00
VMPEG_IFRAME_DISTANCE 45
VMPEG_PFRAME_DISTANCE 0
VMPEG_PROGRESSIVE 0
VMPEG_DENOISE 1
VMPEG_BITRATE 1000000
VMPEG_DERIVATIVE 1
VMPEG_QUANTIZATION 15
VMPEG_CMODEL 0
VMPEG_FIX_BITRATE 0
VMPEG_SEQ_CODES 0
VMPEG_PRESET 0
VMPEG_FIELD_ORDER 0
H264_BITRATE 2000000
H264_QUANTIZER 5
H264_FIX_BITRATE 0
DIVX_BITRATE 2000000
DIVX_RC_PERIOD 50
DIVX_RC_REACTION_RATIO 45
DIVX_RC_REACTION_PERIOD 10
DIVX_MAX_KEY_INTERVAL 250
DIVX_MAX_QUANTIZER 31
DIVX_MIN_QUANTIZER 1
DIVX_QUANTIZER 5
DIVX_QUALITY 5
DIVX_FIX_BITRATE 1
DIVX_USE_DEBLOCKING 1
MS_BITRATE 1000000
MS_BITRATE_TOLERANCE 500000
MS_INTERLACED 0
MS_QUANTIZATION 10
MS_GOP_SIZE 45
MS_FIX_BITRATE 1
AC3_BITRATE 640
PNG_USE_ALPHA 0
EXR_USE_ALPHA 0
EXR_COMPRESSION 0
TIFF_CMODEL 0
TIFF_COMPRESSION 0
FORMAT_YUV_USE_PIPE 0
FORMAT_YUV_PIPE 
REEL_NAME cin0000
REEL_NUMBER 0
TCSTART 0
TCEND 0
TCFORMAT 0
</JOB>"  >>$filenamewithfullpathwithoutextension.renderlist
# This second part renders the renderlist
echo "
 `date --rfc-3339=seconds` Rendering renderlist..."
rm -fv $filenamewithoutextension.mov $filenamewithoutextension.ac3 $filenamewithoutextension.wav $filenamewithoutextension.mp3
nice cinelerra -r $filenamewithoutextension.renderlist
rm $filenamewithoutextension.renderlist
# End subroutine declaration
}
# the following line calls the above-declared subroutine
# and can be commented out with a single hash:
 render_raw_audiovideo




# declaring make_m2ts_bluray subroutine so that it can be commented out with just one '#' afterwards
make_m2ts_bluray()
{
echo "
 `date --rfc-3339=seconds` Constructing m2ts for blu-ray...
 =========================================================="
rm -f ffmpeg2pass-0.log junk.h264 x264_2pass.log
# Archived ffmpeg lines
# I am frustrated that ffmpeg changes so that working encoding commands stop working,
# and it takes a long time to re-discover the new encoding command.
# 1. For old ffmpeg
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -b 24000k -bf 2 -coder 1 -trellis 1 -flags +loop -y -r 50 junk.h264
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -b 24000k -bf 2 -coder 1 -trellis 1 -flags +loop -y -r 50 $1.h264
# 2. Lines worked, then mixed up frames without specifying keyint (-g =1)
# nice ffmpeg -threads 0 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -vpre fastfirstpass -b 26000k -bt 26000k -maxrate 30000k -bufsize 78125k -y -r 50 junk.h264
# nice ffmpeg -threads 0 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -vpre hq            -b 26000k -bt 26000k -maxrate 30000k -bufsize 78125k -y -r 50 $1.h264
# 3. Three reference frames used to work in vlc and xine
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 1 -vcodec libx264 -vpre slower_firstpass -b 26000k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 3 -g 0 -threads 0 -y -r 50 junk.h264
# nice ffmpeg -r 50 -i $1.mov -s 1280x720 -pass 2 -vcodec libx264 -vpre slower           -b 26000k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 3 -g 0 -threads 0 -y -r 50 $1.h264
# 4. Single line attempt with preset, not compatible with PS3
# nice ffmpeg -r 50 -i $filenamewithoutextension.mov -s 1280x720 -nr 30 -qns 100 -vcodec libx264 -vpre libx264-lossless_slower -b 19500k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 $filenamewithoutextension.h264
# 5. Worked until November 2011
# nice ffmpeg -r 50 -i $filenamewithoutextension.mov -s 1280x720 -pass 1 -nr  0 -qns 100 -vcodec libx264 -vpre slower_firstpass -b 19500k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 junk.h264
# nice ffmpeg -r 50 -i $filenamewithoutextension.mov -s 1280x720 -pass 2 -nr 30 -qns 100 -vcodec libx264 -vpre slower           -b 19500k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 $filenamewithoutextension.h264
# 6. Now is 15/Nov/2011
# Maximum blu-ray bitrates.  My consumer-grade camcorder cannot justify such a high bitrate                                                -b 26000k           -maxrate 37000k -bufsize 30000k 
# "-preset fast" plays video back on ps3, "-preset slower" gives a black screen with audio only at 1080i                           medium, try slow?
nice ffmpeg -i $filenamewithoutextension.mov -s 1280x720 -pass 1 -nr  0 -qns   0 -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -preset:v medium -b:v 19500k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 junk.h264
nice ffmpeg -i $filenamewithoutextension.mov -s 1280x720 -pass 2 -nr 30 -qns 100 -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -preset:v medium -b:v 19500k -bt 1000k -maxrate 37000k -bufsize 30000k -bf 2 -g 0 -threads 0 -y -r 50 $filenamewithoutextension.h264
rm -f ffmpeg2pass-0.log junk.h264 x264_2pass.log x264_2pass.log.mbtree
rm -f $filenamewithoutextension.meta
echo "MUXOPT --no-pcr-on-video-pid --new-audio-pes --vbr  --vbv-len=500
V_MPEG4/ISO/AVC, \"$filenamewithoutextension.h264\", fps=50, insertSEI, contSPS
A_AC3, \"$filenamewithoutextension.ac3\", lang=eng
A_LPCM, \"$filenamewithoutextension.wav\", lang=eng" >> $filenamewithoutextension.meta
./tsMuxeR $filenamewithoutextension.meta ../output/m2ts_bluray/$filenamewithoutextension.m2ts
rm $filenamewithoutextension.meta
rm -f ../output/m2ts_bluray/$filenamewithoutextension.m2ts.ffindex
}
# the following line calls the above-declared subroutine
# and can be commented out with a single hash:
# make_m2ts_bluray




# declaring make_m2ts_avchd_dvd subroutine so that it can be commented out with just one '#' afterwards
make_m2ts_avchd_dvd()
{
echo  -e "
 `date --rfc-3339=seconds` \033[1mConstructing m2ts for AVCHD DVD...\033[0m
 ============================================================"
rm -f ffmpeg2pass-0.log junk.h264 x264_2pass.log
# Maximum AVCHD bitrates on DVD medium is 18Mbps                                                                                    -b:v 16000k           -maxrate 17000k -bufsize 20000k       -g 0
 nice ffmpeg -i $filenamewithoutextension.mov -s 1280x720 -pass 1 -nr  0 -qns   0 -vcodec libx264 -profile baseline -preset:v slow  -b:v  9900k -bt 1000k -maxrate 17000k -bufsize 20000k -bf 3 -g 0 -threads 0 -y -r 50 junk.h264
 nice ffmpeg -i $filenamewithoutextension.mov -s 1280x720 -pass 2 -nr 30 -qns 100 -vcodec libx264 -profile baseline -preset:v slow  -b:v  9900k -bt 1000k -maxrate 17000k -bufsize 20000k -bf 3 -g 0 -threads 0 -y -r 50 $filenamewithoutextension.h264
rm -f ffmpeg2pass-0.log junk.h264 x264_2pass.log x264_2pass.log.mbtree
rm -f $filenamewithoutextension.meta
echo "MUXOPT --no-pcr-on-video-pid --new-audio-pes --vbr  --vbv-len=500
V_MPEG4/ISO/AVC, \"$filenamewithoutextension.h264\", fps=50, insertSEI, contSPS
A_AC3, \"$filenamewithoutextension.ac3\", lang=eng
A_LPCM, \"$filenamewithoutextension.wav\", lang=eng" >> $filenamewithoutextension.meta
./tsMuxeR $filenamewithoutextension.meta ../output/m2ts_avchd_dvd/$filenamewithoutextension.m2ts
rm -f $filenamewithoutextension.meta
rm -f ../output/m2ts_avchd_dvd/$filenamewithoutextension.m2ts.ffindex
}
# the following line calls the above-declared subroutine
# and can be commented out with a single hash:
make_m2ts_avchd_dvd




# declaring make_MP4_for_mediatomb as a subroutine so that it can be commented out with just one '#' afterwards
make_MP4_for_mediatomb()
{ 
echo "
 `date --rfc-3339=seconds` Making an MP4 which can 
 be played in xine or streamed through mediatomb
 ================================================="
# For higher audio quality can use:                                                         320k
nice ffmpeg -i $filenamewithoutextension.ac3 -sameq -vn -acodec libfaac -ac 2 -ar 48000 -ab 224k -y $filenamewithoutextension.aac
rm -f $filenamewithoutextension.mp4
MP4Box -new ../output/mp4/$filenamewithoutextension.mp4 -add $filenamewithoutextension.h264 -add $filenamewithoutextension.aac -fps 50
}
# the following line calls the above-declared make_MP4_for_mediatomb subroutine
# and can be commented out with a single hash:
# make_MP4_for_mediatomb





# declaring make_mpeg_for_dvd as a subroutine so that it can be commented out with just one '#' afterwards
make_mpeg_for_dvd()
{
echo "
 `date --rfc-3339=seconds` Making a dvd-compatible mpeg...
 ========================================================="
# http://cinelerra.org/docs/split_manual_en/cinelerra_cv_manual_en_20.html
# recommends -b 8600 for the video bitrate
nice ffmpeg -i $filenamewithoutextension.ac3 -i $filenamewithoutextension.mov -target pal-dvd -nr 100 -aspect 16:9 -s 720x576 -b 8600k -maxrate 9050k -target pal-dvd -pass 1 -passlogfile $filenamewithoutextension.passlogfile -y /dev/null
nice ffmpeg -i $filenamewithoutextension.ac3 -i $filenamewithoutextension.mov -target pal-dvd -nr 100 -aspect 16:9 -s 720x576 -b 8600k -maxrate 9050k -target pal-dvd -pass 2 -passlogfile $filenamewithoutextension.passlogfile -y ../output/mpeg/$filenamewithoutextension.mpeg
rm $filenamewithoutextension.passlogfile
}
# the following line calls the above-declared subroutine
# and can be commented out with a single hash:
# make_mpeg_for_dvd




# declaring make_youtubeHD subroutine so that it can be commented out with just one '#' afterwards
make_youtubeHD()
{
echo "
 `date --rfc-3339=seconds` Making a youtube compatible mp4...
 ============================================================"
nice ffmpeg -i $filenamewithoutextension.mp3 -i $filenamewithoutextension.mov -vcodec libx264 -preset fast -b 2000k -r 25 -s 1280x720 -acodec libfaac -ab 128k -ac 2 -sameq -pass 1 -f rawvideo -an -y /dev/null 
nice ffmpeg -i $filenamewithoutextension.mp3 -i $filenamewithoutextension.mov -vcodec libx264 -preset fast -b 2000k -r 25 -s 1280x720 -acodec libfaac -ab 128k -ac 2 -sameq -pass 2 -y ../output/youtube/$filenamewithoutextension-youtubeHD.mp4
rm ffmpeg2pass-0.log x264_2pass.log x264_2pass.log.mbtree
}
# the following line calls the above-declared subroutine
# and can be commented out with a single hash:
# make_youtubeHD


#
echo "
 `date --rfc-3339=seconds` Now deleting intermediate files..."
 rm -v $filenamewithoutextension.mov $filenamewithoutextension.ac3 $filenamewithoutextension.h264 $filenamewithoutextension.wav $filenamewithoutextension.mp3 $filenamewithoutextension.aac $filenamewithoutextension.passlogfile-0.log $filenamewithoutextension.yuv

#
echo "
 ===================================
 `date --rfc-3339=seconds` Finished!
 ==================================="

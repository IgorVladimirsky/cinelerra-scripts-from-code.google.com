# Cinelerra scripts from code.google.com

I am not an author of these scripts.

The scripts were imported by me from https://code.google.com/archive/p/cinelerra-scripts/

-------------------------------------

Introduction
--------------
I have made some shell scripts to help me with my video editing in Cinelerra.

These can be downloaded from the trunk directory http://code.google.com/p/cinelerra-scripts/source/browse/trunk

The flagship script is render-1080p50.sh.

This takes a cinelerra.xml file and outputs an AVCHD / PS3 compatible 1080p50 video in ../output/m2ts_avchd_dvd.

It also produces a DVD compatible mpeg in ../output/mpeg.


Inspiration.
-----------------
I have taken inspiration from several other related projects: 
* tsMuxeR is expected in the path, downloadable from http://www.afterdawn.com/software/audio_video/video_editing/tsmuxer_linux.cfm. (It no longer available from the developer's website.)
 
* Converting M2TS HD-Video to mpeg4 25fps MOV files http://code.google.com/p/hdffxvrt/

* Cleaning up cinelerra xml files http://duq.ca/duqamuq/?p=340

* Speeding up video http://pr0gr4mm3r.com/linux/how-to-create-a-time-lapse-video-using-ffmpeg/

* ffmpeg intermediate guide to wmv encoding http://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/WMV

* Encoding for an 800x480 pixel resolution tablet phone http://alien.slackbook.org/blog/re-encoding-video-for-android/

#!/bin/bash

# make-all-renderlists.sh script
# (c) nabster http://code.google.com/p/cinelerra-scripts
# distribute under GPL

#
# Cleanup
rm -v *.ac3 *.wav *.mp3 *.mov

for files in `ls -1 *.renderlist`
do
echo Rendering $files
cinelerra -r $files
done

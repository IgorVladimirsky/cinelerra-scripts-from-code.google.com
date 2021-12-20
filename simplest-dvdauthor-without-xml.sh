# simplest-dvdauthor-without-xml.sh script
# (C) nabster
# Distribute under GPL
#
# Takes the DVD-compatible mpeg files
# from from the standard-mpeg-for-dvd directory
# and assembles a simple DVD without menus
#
# Usage: make-standard-mpeg-for-dvd.sh

echo "Initial cleanup"
nice rm -rf dvdauthor-output/*

# ----> Start loop
for files in `ls *.mpeg`
do
echo Processinging $files
nice dvdauthor -o dvdauthor-output/ -t $files
done
# End loop <-
nice dvdauthor -o dvdauthor-output/ -T
nice mkisofs -v -V nabster -dvd-video -o dvdauthor-output.iso dvdauthor-output
nice dvdisaster -i dvdauthor-output.iso -mRS02 -c
sleep 5s
nice dvdisaster -d /dev/sr0 -s
echo "dvdauthor-output.iso ready to re-burn!"

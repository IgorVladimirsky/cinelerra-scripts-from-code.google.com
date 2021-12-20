# join-all-MTS-into-a-bluray.sh script
# (c) nabster http://code.google.com/p/cinelerra-scripts
# distribute under GPL

echo "Cleaning old files and creating directories..."

rm -rfv ../bluray
mkdir -p ../bluray
rm join-all-MTS-into-a-bluray.meta

echo "Making the meta file for tsMuxeR..."

echo -n "MUXOPT --no-pcr-on-video-pid --new-audio-pes --blu-ray --vbr  --auto-chapters=2 --vbv-len=500
V_MPEG4/ISO/AVC, " >> join-all-MTS-into-a-bluray.meta

for files in `ls -1 *.MTS`
do
echo -n "+\"$files\"" >> join-all-MTS-into-a-bluray.meta
done

echo -n ", fps=25, insertSEI, contSPS, ar=As source, track=4113
A_AC3,"  >> join-all-MTS-into-a-bluray.meta

for files in `ls -1 *.MTS`
do
echo -n "+\"$files\""  >> join-all-MTS-into-a-bluray.meta
done

echo -n ", track=4352"  >> join-all-MTS-into-a-bluray.meta

echo "Running tsMuxeR..."

./tsMuxeR join-all-MTS-into-a-bluray.meta ../bluray

echo "Done, now use ImgBurn to make the udf 2.5 filesystem blu-ray disk."

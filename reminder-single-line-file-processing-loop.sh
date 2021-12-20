# Example 1 runs a custom script on all mkv files in the current directory
for i in `ls *.mkv`; do ./mkv2m2ts.sh $i; done

# Example 2 reduces jpeg image size to a quarter without any visible loss in quality. The big steps help loading over slow internet connections.
for i in `ls *.JPG`; do c44 -decibel 47 -slice 2,12,72,83,93,103 -bpp  0.001,0.01,0.02,0.10,0.25,0.5,1 $i; done

# Example 3 converts all pdf files into djvu files. -j0 automatically chooses the number of threads.
for i in `ls *.pdf`; do pdf2djvu --dpi=600 -j0 -o $i.djvu $i ; done

# Example 4 adds all djvu files in directory cpd-temp to the file 2012-CPD-certificates.djvu
for i in `ls cpd-temp/*.djvu` ; do djvm -i 2012-CPD-certificates.djvu $i ; echo $i ; done

# Combo example: converts all .jpg files to .djvu and puts them into a new bundle called pictures-bundle.djvu
for i in `ls *.jpg`; do c44 -decibel 47 -slice 2,12,72,83,93,103 -bpp  0.001,0.01,0.02,0.10,0.25,0.5,1 $i; done && for i in `ls *.djvu` ; do pagelist="$pagelist $i" ; done ; djvm -c pictures-bundle.djvu $pagelist

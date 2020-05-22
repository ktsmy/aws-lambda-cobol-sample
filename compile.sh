cd cobol
mkdir binaries
for f in *.cob;
    do \
        tmp=$(echo "$f" | cut -f 1 -d '.')
        COB_LDFLAGS="" cobc -x $f -o binaries/$tmp
        echo $tmp
    done
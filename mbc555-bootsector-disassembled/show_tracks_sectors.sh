if [[ $# -eq 0 ]] ; then
    echo "Usage: $0 {img_filename}"
    exit 0
fi

set -e

# hxcfe -finput:"$0" \
#    -conv:BMP_DISK_IMAGE -foutput:"tmp.bmp"

  hxcfe -finput:"$1" \
     -conv:HXC_HFE -foutput:"output.hfe" \
     -conv:BMP_DISK_IMAGE -foutput:"output.bmp"

# open tmp.bmp


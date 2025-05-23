base=cashman-game
flashfloppy_image_folder=/Volumes/FLASHFLOPPY/diskimages/
flashfloppy_image_prefix="0280. "

set -e

nasm -w-label-orphan $base.asm -o $base.img -l $base.lst
# -w-user 

if [ -d $flashfloppy_image_folder ]; then
	cp $base.img "$flashfloppy_image_folder$flashfloppy_image_prefix$base.img"
	hdiutil unmount $flashfloppy_image_folder -force
else
  echo "$flashfloppy_image_folder not found. No file copied."
fi

# /Users/rick/bin/hxcfe -finput:"$base.img" \
#    -conv:HXC_HFE -foutput:"$base.hfe" \
#    -conv:BMP_DISK_IMAGE -foutput:"$base.bmp"

# open "$base.bmp"


# -debug -verbose -effect scanlines 
if pgrep -x "mbc55xtest" > /dev/null; then
	killall -9 mbc55xtest
fi

./mbc55xtest mbc55x -flop1 $base.img -debug -debugscript autostart.txt -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 930x700 -prescale 1 

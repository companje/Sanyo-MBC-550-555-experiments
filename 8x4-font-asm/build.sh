prefix="0286. 8x4font-"
base=app
flashfloppy_image_folder=/Volumes/FLASHFLOPPY/diskimages/

# set -x
set -e

nasm -w-label-orphan "$base.asm" -o "$base.img" -l "$base.lst"

# -w-user 

if [ -d $flashfloppy_image_folder ]; then
	cp "$base.img" "$flashfloppy_image_folder$prefix$base.img"
	hdiutil unmount $flashfloppy_image_folder -force
else
  echo "$flashfloppy_image_folder not found. No file copied."
fi

# /Users/rick/bin/hxcfe -finput:"$base.img" \
#    -conv:HXC_HFE -foutput:"$base.hfe" \
#    -conv:BMP_DISK_IMAGE -foutput:"$base.bmp"

# open "$base.bmp"

# -debug -verbose -effect scanlines 
if pgrep -x "mame" > /dev/null; then
	killall -9 mame
fi

img=`pwd`/$base.img

# cd ../mame
# 930x700
# -debugscript autostart.txt 
# -debugger gdbstub -debugger_host 0.0.0.0 
# ./mbc55xtest

# -autoboot_script script.lua 
mame mbc55x -flop1 "$img" -debug -debugscript autostart.txt -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 800x600 -prescale 2 -gamma 3 -contrast 1.5



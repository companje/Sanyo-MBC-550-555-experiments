
base=green
flashfloppy_image_folder=/Volumes/FLASHFLOPPY/diskimages/
flashfloppy_image_prefix="0275. "

set -e

nasm -w-user -w-label-orphan $base.asm -o $base.img -l $base.lst

if [ -d $flashfloppy_image_folder ]; then
	cp $base.img "$flashfloppy_image_folder$flashfloppy_image_prefix$base.img"
	hdiutil unmount $flashfloppy_image_folder -force
else
  echo "$flashfloppy_image_folder not found. No file copied."
fi

# -debug -verbose -effect scanlines 
if pgrep -x "mbc55xtest" > /dev/null; then
	killall -9 mbc55xtest
fi

# 800x600 \
./mbc55xtest mbc55x -debug -debugscript autostart.txt -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 2560x1600 -prescale 4 \
-flop1 $base.img 
# &



	# -hdiutil detach /dev/disk4
	# -hdiutil unmount /Volumes/Untitled/ -force

	# -open -W bootpic.img	
	# -open /Volumes/Untitled/

 # -debug 


	# 	ls /Volumes/

	# 	hdiutil unmount /Volumes/Untitled/ -force

	# 	cp bootpic.img "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/emulator/Sanyo_MBC_555/data/"

	# 	cp bootpic.img "/Volumes/FLASHFLOPPY/diskimages/0273. bootpic.img"
	# 	hdiutil unmount /Volumes/FLASHFLOPPY -force

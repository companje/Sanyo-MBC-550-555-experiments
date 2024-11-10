build:
	nasm -w-user -w-label-orphan bootpic.asm -o bootpic.img -l bootpic.lst
	
	-hdiutil detach /dev/disk4
	-hdiutil unmount /Volumes/Untitled/ -force

	-open -W bootpic.img	
	-open /Volumes/Untitled/

# ./mbc55xtest mbc55x -debug -ramsize 256K -verbose -skip_gameinfo -effect scanlines -window -nomaximize -resolution0 800x600 -flop1 floppies/disk-a.img


	# 	ls /Volumes/

	# 	hdiutil unmount /Volumes/Untitled/ -force

	# 	cp bootpic.img "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/emulator/Sanyo_MBC_555/data/"

	# 	cp bootpic.img "/Volumes/FLASHFLOPPY/diskimages/0273. bootpic.img"
	# 	hdiutil unmount /Volumes/FLASHFLOPPY -force

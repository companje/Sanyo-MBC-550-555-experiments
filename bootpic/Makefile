build:
	nasm -w-user -w-label-orphan bootpic.asm -o bootpic.img -l bootpic.lst
	
	-hdiutil detach /dev/disk4
	-hdiutil unmount /Volumes/Untitled/ -force

	-open -W bootpic.img	
	-open /Volumes/Untitled/



	# 	ls /Volumes/

	# 	hdiutil unmount /Volumes/Untitled/ -force

	# 	cp bootpic.img "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/emulator/Sanyo_MBC_555/data/"

	# 	cp bootpic.img "/Volumes/FLASHFLOPPY/diskimages/0273. bootpic.img"
	# 	hdiutil unmount /Volumes/FLASHFLOPPY -force

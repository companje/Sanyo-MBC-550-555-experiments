build:
	nasm audio.asm -o audio.img -l audio.lst
	cp audio.img /Users/rick/Sanyo/Sanyo-MBC-550-555-repo/emulator/Sanyo_MBC_555/data/audio.img
	
	cp audio.img /Volumes/FLASHFLOPPY/0130-audio.img
	hdiutil unmount /Volumes/FLASHFLOPPY -force

# 	hdiutil attach 0001-mbc555-bootsector.img
# 	hdiutil unmount /Volumes/SYSTEM -force
# 	hdiutil attach /Volumes/FLASHFLOPPY/0001-mbc555-bootsector.img
# 	diskutil eject "/dev/disk5"
# 	diskutil eject "/dev/disk4"

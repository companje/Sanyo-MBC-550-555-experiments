build: 
	nasm custom-bootsector-rick.asm -o 0001-mbc555-bootsector.img -l myfile.lst
	cp 0001-mbc555-bootsector.img /Users/rick/Sanyo/i8086/Intel8086-master/src/fr/neatmonster/ibmpc/data
	cp 0001-mbc555-bootsector.img /Volumes/FLASHFLOPPY/
	diskutil eject "/dev/disk4"

# 		xxd 0001-boot.img > 0001-boot.hex
# 		xxd empty-base.img > empty-base.hex
# 		diff 0001-boot.hex empty-base.hex > result.diff

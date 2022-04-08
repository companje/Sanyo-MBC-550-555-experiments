build:
	nasm custom-bootsector-rick.asm -o 0001-mbc555-bootsector.img -l myfile.lst
	cp 0001-mbc555-bootsector.img /Users/rick/Sanyo/Sanyo-MBC-550-555-repo/emulator/Sanyo_MBC_555/data/
	
# 	processing-java --sketch=/Users/rick/Sanyo/Sanyo-MBC-550-555-repo/emulator/Sanyo_MBC_555 --run
	
# 	cp 0001-mbc555-bootsector.img /Volumes/FLASHFLOPPY/
# 	diskutil eject "/dev/disk4"

# 		xxd 0001-boot.img > 0001-boot.hex
# 		xxd empty-base.img > empty-base.hex
# 		diff 0001-boot.hex empty-base.hex > result.diff


# TARGET=template

# .PHONY: all
# all: $(TARGET).bin

# $(TARGET).bin: $(TARGET).asm
# 	nasm -o $@ -f bin -l $(TARGET).lst $<

# .PHONY: clean
# clean:
# 	-rm -f *.bin *.lst

# ---------

# TARGET = template

# .PHONY: all
# all: $(TARGET).bin

# $(TARGET).bin: $(TARGET).exe
# 	@ cp $< tmp.exe
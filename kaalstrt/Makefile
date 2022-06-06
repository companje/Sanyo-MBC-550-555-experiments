project=kaalstrt
emulator_folder=/Users/rick/Sanyo/Sanyo-MBC-550-555-repo/emulator/Sanyo_MBC_555/data
flashfloppy_folder=/Volumes/FLASHFLOPPY
id=0000

build:
	nasm $(project).asm -o $(project).img -l $(project).lst
	cp $(project).img $(emulator_folder)/$(project).img
	
	cp $(project).img $(flashfloppy_folder)/$(id)-$(project).img
	hdiutil unmount $(flashfloppy_folder) -force

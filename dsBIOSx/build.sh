#!/bin/bash
nasm -w-label-orphan -f bin -o dsbios.com dsbios.asm

open /Volumes/FLASHFLOPPY
open /Volumes/FLASHFLOPPY/diskimages/0274.\ bootpic.img

sleep 2

cp dsbios.com /Volumes/Untitled/

# upx --brute --8086 dsbios.com         #optional
# cp dsbios.com /Volumes/

hdiutil detach /dev/disk4
hdiutil detach /dev/disk5
hdiutil detach /dev/disk6

# hdiutil unmount /Volumes/Untitled/ -force
hdiutil unmount /Volumes/FLASHFLOPPY/ -force

# plzwait-boot.img

# open -W bootpic.img  
# open /Volumes/Untitled/




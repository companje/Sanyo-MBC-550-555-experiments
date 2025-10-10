prefix="0400. WHY2025-"
# base=app1-tixy
# base=app2-cityinabottle
# base=app3-plasma
# base=app4-play-freq
# base=app5-play-wav
# base=app6-build-song
# base=app7-duty-cycle
# base=app9-bubble-galaxy
base=app10-bubble-galaxy2
# base=_circle

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

# WAV_OUTPUT=change-freq.wav
# -wavwrite $WAV_OUTPUT 

# -autoboot_script script.lua 
# AVI=out.avi
# -aviwrite $AVI 
res=800x600
# res=400x300
#  
mame mbc55x -nothrottle -flop1 "$img" -debug -debugscript autostart.txt -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 $res -prescale 2 -gamma 3 -contrast 1.5

# ffmpeg -i $WAV_OUTPUT -ss 00:00:02 -filter:a "volume=5dB" -y ${WAV_OUTPUT}.volume.wav

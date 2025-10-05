# LET OP: Versie op de Sanyo is nieuwer!

img="300-debug.img"
flashfloppy_image_folder=/Volumes/FLASHFLOPPY/diskimages/

set -e

# DIT WERKT MAAR STAAT EVEN UIT NU
# if [ -d $flashfloppy_image_folder ]; then
# 	cp "$img" "$flashfloppy_image_folder$img"
# 	hdiutil unmount $flashfloppy_image_folder -force
# else
#   echo "$flashfloppy_image_folder not found. No file copied."
# fi

if pgrep -x "mame" > /dev/null; then
	killall -9 mame
fi


# -aviwrite screendump.avi

mame mbc55x -flop1 "$img" -speed 40.0 -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 800x600 -prescale 2 -gamma 3 -contrast 1.5
 # -debug -debugscript autostart.txt 


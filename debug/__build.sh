img="0008-Basic Siene oa. crt (disk1127).img"
# img="0001. Sanyo MBC-550 Systemdisk I - MS-DOS 1.25 - BASIC 1.32.img"
mame mbc55x -flop1 "$img" -debug -debugscript autostart.txt -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 800x600 -prescale 2 -gamma 3 -contrast 1.5

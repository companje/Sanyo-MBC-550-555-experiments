
# -debug -verbose -effect scanlines 
if pgrep -x "mbc55xtest" > /dev/null; then
	killall -9 mbc55xtest
fi

./mbc55xtest mbc55x -flop1 MS-DOS-2.11.img -flop2 cashman_ORG.img -debug -debugscript autostart.txt -ramsize 256K -skip_gameinfo -window -nomaximize -resolution0 930x700 -prescale 1 

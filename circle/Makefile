TARGET=circle

.PHONY: all
all: $(TARGET).com

$(TARGET).com: $(TARGET).asm
	-killall -9 DOSBox
	nasm -o $@ -f bin -l $(TARGET).lst $<
	cp $(TARGET).com ~/c
	open /Applications/dosbox.app

.PHONY: clean
clean:
	-rm -f *.com *.lst
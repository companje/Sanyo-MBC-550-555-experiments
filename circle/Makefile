TARGET=circle

.PHONY: all
all: $(TARGET).com

$(TARGET).com: $(TARGET).asm
	nasm -o $@ -f bin -l $(TARGET).lst $<
	cp $(TARGET).com ~/c

.PHONY: clean
clean:
	-rm -f *.com *.lst
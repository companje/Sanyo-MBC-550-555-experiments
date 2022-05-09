# TIXYBOOT.ASM 
tixyboot.asm by Rick Companje, 2021-2022, MIT licence.

A tribute to Martin Kleppe's beautiful https://tixy.land as well as a tribute to the Sanyo MBC-550/555 PC (1984) which forced me to be creative with code since 1994.

The Sanyo MBC-55x has a very limited ROM BIOS. After some hardware setup by the ROM BIOS a RAM BIOS loaded from floppy takes over. This means that we don't have any BIOS functions when running our own code from the bootsector. 

The Sanyo has no display mode 13 (not even with the original RAM BIOS). It uses a 6845 video chip with three bitmapped graphics planes and is organized as 50 rows by 72 (or 80) columns. One column consists of 4 bytes. Then the next column starts. After 72 columns a new row starts. A bitmap of 16x8 pixels is made up of 2 columns on row 1 and 2 columns on row 2.

To run this code write the compiled code to the bootsector of a Sanyo MBC-55x floppy or use an emulator like the one written in Processing/Java in this repo.

Add your own visuals by adding your own functions to the fx_table.

```
t = time  0..255
i = index 0.255
x = x-pos 0..15
y = y-pos 0..15

result: 
  al -15..15 (size and color)
  al<0 red, al>0 white
```

<img src="screengrab.gif">

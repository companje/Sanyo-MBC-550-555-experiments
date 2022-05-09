# TIXYBOOT.ASM 
tixyboot.asm by Rick Companje, 2021-2022, MIT licence.

A tribute to Martin Kleppe's beautiful https://tixy.land as well as a tribute to the Sanyo MBC-550/555 PC (1984) which forced me to be creative with code since 1994.

The Sanyo MBC-55x has a very limited ROM BIOS. After some hardware setup by the ROM BIOS a RAM BIOS loaded from floppy takes over. This means that we don't have any BIOS functions when running our own code from the bootsector. 

The Sanyo has no display mode 13 (not even with the original RAM BIOS). It uses a 6845 video chip with three bitmapped graphics planes and is organized as 50 rows by 72 (or 80) columns. One column consists of 4 bytes. Then the next column starts. After 72 columns a new row starts. A bitmap of 16x8 pixels is made up of 2 columns on row 1 and 2 columns on row 2.

To run this code write the compiled code to the bootsector of a Sanyo MBC-55x floppy or use an emulator like the one written in Processing/Java in this repo.

<img src="doc/sanyo-mbc-555-tixy.jpg" width="600">

Add your own visuals by adding your own functions to the fx_table.

```
t = time  0..255
i = index 0..255
x = x-pos 0..15
y = y-pos 0..15

result: 
  al -15..15 (size and color)
  al<0 red, al>0 white
```

<img src="doc/screengrab.gif">

**Note: this code will only work on a Sanyo MBC-550/555!**

See <a href="https://github.com/companje/Sanyo-MBC-550-555-experiments/blob/main/tixyboot.asm/tixyboot.asm">full source code</a>.

```asm
; ...

; using dx and bx registers as t,i,x,y variables
%define t dh
%define i dl
%define x bh
%define y bl

jmp setup

fx_table:      ; the 'effects' table: 8 bytes, overwriting the 'Sanyo1.2' tag
    db fx0,fx1,fx2,fx3,fx4,fx5,fx6,fx7 

; ...

fx0: ; x
    mov al,x
    ret

fx1: ; y-7
    mov al,y
    sub al,7
    ret

fx2: ; y+t
    mov al,y
    add al,t
    ret

fx3: ; y-t
    mov al,y
    sub al,x
    ret

fx4: ; sin(x+y+t)
    mov al,x
    add al,y
    add al,t
    call sin
    ret

fx5: ; bitmap_data[i+t]
    push bx
    mov al,i
    add al,t
    mov bx,bitmap_data
    xlat
    pop bx
    ret

fx6: ; -8*(y-x)+t
    mov cl,-8
    mov al,y
    sub al,x
    mul cl
    call limit
    add al,t
    ret

fx7: ; sin(sqrt(x^2+y^2))-t)
    mov al,i   ; isqrt_table[i] = sqrt(x^2+y^2)
    push bx
    mov bx,isqrt_table
    xlat
    pop bx
    sub al,t
    call sin
    ret

; ...

setup:
; ...

draw:
; ...


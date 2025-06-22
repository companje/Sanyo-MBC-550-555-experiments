void drawSprite() {
  bx = mem[si] | ((mem[si + 1] & 0xFF) << 8);
  si += 2;
  drawPic();
}

void drawPic() {
  es = R;
  drawChannel();
  es = G;
  drawChannel();
  es = B;
  drawChannel();
}

void drawChannel() {
  int rows = bx >> 8;
  int cols = bx & 0xFF;
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      mem[es + di++] = mem[si++];
      mem[es + di++] = mem[si++];
    }
    di += cols * 2;
    di -= cols * 4;
  }
}




//void drawSprite(int si) {
//  int cols = mem[si++];
//  int rows = mem[si++];

//  println(rows, cols);
//  //for (int c=0; c<3; c++) {
//  for (int row=0; row<rows; row++) {
//    for (int col=0; col<cols; col++) {
//      mem[channel + di] = 255; //channels[c]
//      di++;
//      si++;
//    }
//    di-=cols*4;
//    di+=COLS*4;
//  }
//  di-=rows*COLS*4 - cols*4;
//  //}
//}

//draw_spr:
//  push bx
//  mov bx,[si]
//  inc si
//  inc si
//  call draw_pic
//  pop bx
//  ret

//draw_pic:
//  push ax
//  mov ax, RED
//  call draw_channel
//  mov ax, GREEN
//  call draw_channel
//  mov ax, BLUE
//  call draw_channel
//  pop ax
//  ret

//; ───────────────────────────────────────────────────────────────────────────

//draw_channel:
//  push di
//  mov es,ax
//  xor cx,cx
//  mov cl,bh        ; rows (bl)
//.rows_loop:
//  push cx
//  xor cx,cx
//  mov cl,bl        ; cols (bh)
//.cols_loop:
//  movsw
//  movsw
//  loop .cols_loop
//  add di,COLS*4    ; one row down
//  mov ah,0
//  mov al,bl
//  times 2 shl ax,1
//  sub di,ax       ; di-=4*bh   ; bh cols to the left on the new row
//  pop cx
//  loop .rows_loop
//  pop di
//  ret


void loadSprite(String filename, int addr) {
  byte b[] = loadBytes(filename);
  for (int i=0; i<b.length; i++) {
    mem[addr+i] = b[i];
  }
}

void calc_di(int x, int y) { //for cell, not pixel
  di = y * 288 + x * 4;
}

void setImageFromMemory(PImage img) {
  img.loadPixels();
  for (int y=0, bit=128, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (mem[R+i] & bit)>0 ? 255 : 0;
      int g = (mem[G+i] & bit)>0 ? 255 : 0;
      int b = (mem[B+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
}

void setMemoryFromImage(PImage img) { //expects 3-bit full R,G,B,W,C,M,Y,K
  img.loadPixels();
  for (int y=0, bit=0, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      if ((int(red(img.pixels[j]))&255)>0) mem[R+i] |= bit;
      //else mem[R+i] &= ~bit;
      if ((int(green(img.pixels[j]))&255)>0) mem[G+i] |= bit;
      //else mem[G+i] &= ~bit;
      if ((int(blue(img.pixels[j]))&255)>0) mem[B+i] |= bit;
      //else mem[B+i] &= ~bit;
    }
  }
}

void clearChannels(boolean r, boolean g, boolean b) {
  for (int i=0; i<COLS*4*50; i++) {
    if (r) mem[R+i] = 0;
    if (g) mem[G+i] = 0;
    if (b) mem[B+i] = 0;
  }
}

void clearAll() {
  clearChannels(true, true, true);
}

void clearR() {
  clearChannels(true, false, false);
}

void clearG() {
  clearChannels(false, true, false);
}

void clearB() {
  clearChannels(false, false, true);
}

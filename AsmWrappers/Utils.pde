void world2screen() { // input (ax,bx) = (world.x, world.y)   ; screen (row,col) ; output (bx)
  //; WORLD:
  //;   0..73728  (65536) -> col
  //;   0..51200  (=1024*50) -> row
  //; SCREEN (ROW,COL):
  //;   0..49 (row)
  //;   0..71 (col)
  push(cx);
  mov(cl, 10);
  shr(bx, cl); //bl=row 0..49
  shr(ax, cl);
  dec(cl);
  dec(cl); //cl=8
  shl(bx, cl);
  //; mov bh,al   ; //bh=col 0..71
  //; xchg bh,bl
  or(bx, ax);
  pop(cx);
}
  
void draw_img(PImage img) {
  int row = di.get() / 288;
  int col = di.get() % 288;
  image(img, col*8/4, row*8, img.width, img.height*2);
}

void set_cursor(int row, int col) {
  if (row<1) row=1;
  if (col<1) col=1;
  di.set( (row-1) * BYTES_PER_ROW + (col-1) * 4 ); // one based
}

void setImageFromMemory(PImage img) {
  img.loadPixels();
  for (int y=0, bit=128, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (mem8(RED*16+i).get() & bit)>0 ? 255 : 0;
      int g = (mem8(GREEN*16+i).get() & bit)>0 ? 255 : 0;
      int b = (mem8(BLUE*16+i).get() & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
}


int incbin(String filename) {
  byte bytes[] = loadBytes(filename);
  for (byte b : bytes) {
    mem8(Mem.mem_counter++).set(b);
  }
  return Mem.mem_counter-bytes.length; //return start address, mem_counter=endpos
}

void draw_sprite() { //si=location of sprite with 2 byte header
  push(bx);
  mov(bx, mem(si)); //// moet dit niet expliciet ds:si zijn ??
  inc(si);
  inc(si);
  draw_pic();
  pop(bx);
}

void draw_pic() {
  push(ax);
  mov(ax, RED);
  draw_channel();
  mov(ax, GREEN);
  draw_channel();
  mov(ax, BLUE);
  draw_channel();
  pop(ax);
}

void draw_channel() {
  //deze kwam in een endless loop doordat si niet altijd goed werd gezet
  push(di);
  mov(es, ax);
  mov(cx, 0);
  mov(cl, bh);      // rows (bl)
  do { //.rows_loop
    push(cx);
    mov(cx, 0);
    mov(cl, bl);     // cols (bh)
    do {            // .cols_loop
      movsw();
      movsw();
    } while (loop_cx());
    add(di, COLS*4); //COLS*4
    mov(ah, 0);
    mov(al, bl);
    shl(ax, 1);
    shl(ax, 1);
    sub(di, ax);
    pop(cx);
  } while (loop_cx()); //loop .rows_loop
  pop(di);
}


void assertObject(Object o, String msg) {
  assertTrue(o!=null, msg);
}

void assertTrue(boolean b, String msg) {
assert b :
  msg;
}

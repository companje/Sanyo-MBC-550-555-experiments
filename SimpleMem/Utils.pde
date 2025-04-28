
void setImageFromMemory(PImage img) {
  img.loadPixels();
  for (int y=0, bit=128, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (mem(RED, i).getByte() & bit)>0 ? 255 : 0;
      int g = (mem(GREEN, i).getByte() & bit)>0 ? 255 : 0;
      int b = (mem(BLUE, i).getByte() & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
}

int incbin(String filename) {
  byte bytes[] = loadBytes(filename);
  for (byte b : bytes) {
    mem(mem_counter++).setByte(b);
  }
  return mem_counter-bytes.length; //return start address, mem_counter=endpos
}

void set_row_col(int row, int col) {
  di.set( (row-1) * BYTES_PER_ROW + (col-1) * 4 ); // one based
}

void draw_img(PImage img) {
  int row = di.get() / 288;
  int col = di.get() % 288;
  image(img, col*8/4, row*8, img.width, img.height*2);
}

void draw_sprite() { //si=location of sprite with 2 byte header
  push(bx);
  //println(si,mem(si));
  mov(bx, mem(cs, si));

  println("si", si);
  println("mem(cs,si)", mem(cs, si));
  println("mem(cs,si+1)", mem(cs, si.get()+1));
  //mov(bx,0x0808);
  //BX BEVAT NOG NIET 0x0808. iets mis met mov(bx, mem(cs, si)); ???

  println(hex(mem(cs, si).getWord(), 4));

  println(bx, si);
  inc(si);
  inc(si);
  println("mem(cs,si)", mem(cs, si));

  System.exit(0);
  draw_pic();
  pop(bx);
}

boolean loop_cx() {
  dec(cx);
  return cx.get()>0;
}

void draw_pic() {
  push(ax);
  println("drawpic", bx);
  mov(ax, RED);
  draw_channel();
  //mov(ax,GREEN);
  //draw_channel();
  //mov(ax,BLUE);
  //draw_channel();
  pop(ax);
}

void draw_channel() {
  //deze kwam in een endless loop doordat si niet altijd goed werd gezet
  println("draw_channel", bx);
  push(di);
  mov(es, ax);
  mov(cx, 0);
  mov(cl, bh);      // rows (bl)
  //println("FIXME: ",bx,bh,bl,cx,cl);
  do { //.rows_loop
    push(cx);
    mov(cx, 0);
    mov(cl, bl);     // cols (bh)
    do {            // .cols_loop
      movsw();
      movsw();
    } while (loop_cx());
    //println("cols loop done");
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

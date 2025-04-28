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

void stosw() {
  mem16(es.get()*16 + di.get()).set(ax.get());
  di.inc();
  di.inc();
}

void movsw() {
  int v = mem16(ds.get()*16 + si.get()).get();
  mem16(es.get()*16 + di.get()).set(v);
  di.inc();
  di.inc();
  si.inc();
  si.inc();
}

int incbin(String filename) {
  byte bytes[] = loadBytes(filename);
  for (byte b : bytes) {
    mem8(Mem.mem_counter++).set(b);
  }
  return Mem.mem_counter-bytes.length; //return start address, mem_counter=endpos
}

void draw_sprite() { //si=location of sprite with 2 byte header
  bx.push();
  //println(si,mem(si));
  bx.mov(mem(si));
  //println(si);
  //println("mem(si)", mem(si));
  //println(bx,si);
  si.inc();
  si.inc();
  draw_pic();
  bx.pop();
}

void draw_pic() {
  ax.push();
  ax.mov(RED);
  draw_channel();
  ax.mov(GREEN);
  draw_channel();
  ax.mov(BLUE);
  draw_channel();
  ax.pop();
}

boolean loop_cx() {
  cx.dec();
  return cx.get()>0;
}

void draw_channel() {
  //deze kwam in een endless loop doordat si niet altijd goed werd gezet
  di.push();
  es.mov(ax);
  cx.set(0);
  cl.mov(bh);      // rows (bl)
  do { //.rows_loop
    cx.push();
    cx.mov(0);
    cl.mov(bl);     // cols (bh)
    do {            // .cols_loop
      movsw();
      movsw();
    } while (loop_cx());
    di.add(COLS*4); //COLS*4
    ah.mov(0);
    al.mov(bl);
    ax.shl();
    ax.shl();
    di.sub(ax);
    cx.pop();
  } while (loop_cx()); //loop .rows_loop
  di.pop();
}

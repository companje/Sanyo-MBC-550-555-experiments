int bl() {
  return bx&255;
}

int bh() {
  return bx>>8;
}

int dw(int v) {
  mem[j] = v<<8;
  mem[j+1] = v&255;
  j+=2;
  return j;
}

void set_cursor(int row, int col) {
  di = (row-1) * BYTES_PER_ROW + (col-1) * 4; // one based
}

void draw_img(PImage img) {
  int row = di / 288;
  int col = di % 288;
  image(img, col*8/4, row*8, img.width, img.height*2);
}

void world2screen() { //input (ax,bx)=(world.x, world.y) -> output (bx)=screen (row,col) ;
  stack.push(cx);
  cx = 10;  // cl=10
  bx >>= (cx & 0xff);  //shr bx,cl  =>  bx/=1024
  ax >>= (cx & 0xff);  //shr ax,cl  =>  ax/=1024
  bx = (bx&0xff)<<8 | ax&0xff; //  //bl=row 0..49    //bh=col 0..71
  cx = stack.pop();
}

void calc_di_from_bx() {  //  ; input bl,bh [0,0,71,49]
  ax=144;      //2*72 cols
  ax*=bh();    //bh*=144 resultaat in AX
  ax<<=1;      //verdubbel AX
  di=ax;       //di=ax (=bh*288)
  bx=bl();     //mov bh,0
  bx<<=1;      //bl*=2
  bx<<=1;      //bl*=2
  di+=bx;      //di+=bl
}

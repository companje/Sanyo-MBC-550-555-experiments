int POS = 0;
int VEL = POS+4;
int FORCES = VEL+4;
int TMP = FORCES+4;
int ANGLE = TMP+4;
int STARS = ANGLE+2;

int NUM_STARS=50;
int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int CENTER=COLS*LINES/2+COLS*4/2;

void setup() {
  size(640, 400, P2D);

  cx.mov(5);
  dx.mov(1);
  ax.mov(5000);
  ax.div(cx);
  
  println(ax,dx);
  println((long)((long)dx.get() << (long)dx.bits | (long)ax.get()));
  
  mem16(POS).mov(73728/2);
  mem16(POS+2).mov(51200/2 - 10000);

  init_stars();
}

void init_stars() {
  cx.mov(NUM_STARS*2);
  do {
    bx.mov(cx);
    mem(bx, +STARS).mov((int)random(0, 0xffff));
  } while (cx.dec()>0);
}

void draw() {
  background(0);
  //draw_stars();
}

void draw_stars() {
  cx.mov(NUM_STARS*2);
  do {
    bx.mov(cx);
    ax.mov(mem(bx, +STARS+0)); //x
    ax.sub(mem(POS+0));
    bx.mov(mem(bx, +STARS+1));
    bx.sub(mem(POS+1)); //y
    //world2screen(); // bl=row 0..49    //bh=col 0..71   checkme
    //calc_di_from_bx();
    //draw_img(img_star[2]);
    cx.dec(); //extra
  } while (cx.dec()>0);
}

void world2screen() { //input (ax,bx)=(world.x, world.y) -> output (bx)=screen (row,col) ;
  cx.push();
  cx.mov(10); // cl=10 ?? cx should be fine right?
  bx.shr(cx); // bx/=1024
  ax.shr(cx); // ax/=1024
  //replace code by: mov bh,al, xchg bh,bl ??????
  cx.dec();
  cx.dec();
  bx.shl(cx); // bx<<=8 ==??? mov bh,bl ???
  bx.or(ax);  // mov bl,al?
  //bl=row 0..49
  //bh=col 0..71
  cx.pop();
}

//void calc_di_from_bx() { //  ; input bl,bh [0,0,71,49]
//  //TODO
//  mov(ax, 144);      // 2*72 cols
//  mul(bh);          // bh*=144 resultaat in AX
//  shl(ax, 1);        // verdubbel AX
//  mov(di, ax);       // di=ax (=bh*288)
//  shl(bl, 1);        // bl*=2
//  shl(bl, 1);        // bl*=2
//  mov(bh, 0);
//  add(di, bx);       // di+=bl
//  //if (jl()) println(di,"di kleiner dan -50");
//  //xor(di,di);  // jl .clamp_top
//}

//void set_cursor(int row, int col) {
//  di.set((row-1) * BYTES_PER_ROW + (col-1) * 4); // one based
//}

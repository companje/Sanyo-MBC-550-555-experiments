int POS = 0;
int VEL = POS+4;
int FORCES = VEL+4;
int TMP = FORCES+4;
int ANGLE = TMP+4;
int STARS = ANGLE+2;

int NUM_STARS=50;

void setup() {
  size(640, 400, P2D);

  mov(mem(POS), 73728/2);
  mov(mem(POS+2), 51200/2 - 10000);

  //init_stars();

  mov(al,100);
  println(di);
  cmp(al, -50);
  println("CMP", al, "=? 0   > ", flags());
  

  exit();
}

void init_stars() {
  mov(cx, NUM_STARS*2);
  do {
    mov(bx, cx);
    mov(mem(bx, +STARS), (int)random(0, 0xffff));
  } while (loop(cx));
}

void draw() {
  background(0);
  //draw_stars();
}

void draw_stars() {
  mov(cx, NUM_STARS*2);
  do {
    mov(bx, cx);
    mov(ax, mem(bx, +STARS+0)); //x
    sub(ax, mem(POS+0));

    mov(bx, mem(bx, +STARS+1));
    sub(bx, mem(POS+1)); //y

    world2screen(); // bl=row 0..49    //bh=col 0..71   checkme

    calc_di_from_bx();
    //draw_img(img_star[2]);


    dec(cx); //extra
  } while (loop(cx));
}

void world2screen() { //input (ax,bx)=(world.x, world.y) -> output (bx)=screen (row,col) ;
  push(cx);
  mov(cx, 10); // cl=10 ?? cx should be fine right?
  shr(bx, cx); // bx/=1024
  shr(ax, cx); // ax/=1024
  //replace code by: mov bh,al, xchg bh,bl ??????
  dec(cx);
  dec(cx);
  shl(bx, cx); // bx<<=8 ==??? mov bh,bl ???
  or(bx, ax);  // mov bl,al?
  //bl=row 0..49
  //bh=col 0..71
  pop(cx);
}

void calc_di_from_bx() { //  ; input bl,bh [0,0,71,49]
  //TODO
  mov(ax, 144);      // 2*72 cols
  mul(bh);          // bh*=144 resultaat in AX
  shl(ax, 1);        // verdubbel AX
  mov(di, ax);       // di=ax (=bh*288)
  shl(bl, 1);        // bl*=2
  shl(bl, 1);        // bl*=2
  mov(bh, 0);
  add(di, bx);       // di+=bl
  
  mov(di,100);
  cmp(di,-50);
  
  //if (jl()) println(di,"di kleiner dan -50");



  //xor(di,di);  // jl .clamp_top
}

String flags() {
  return "ZF="+(ZF?1:0) + " SF="+(SF?1:0) + " CF="+(CF?1:0) + " OF="+(OF?1:0);
}

VideoRAM video = new VideoRAM();

int img_ship[] = new int[24];
int img_up;
int mem[] = new int[1024*1024];
int mem_counter = 0; //incrementing address for memory

void setup() {
  size(640, 400);
  video.setup();
  loadAssets();

  //asm("mov ax,RED");
  mov(ax, RED);
  mov(es, ax);
  println(es);
  mov(di, 0);
  println(di);
  mov(ax, -1); //0xffff
  println(ax);
  stosw();
  mov(ax, 2222);

  println(mem[RED*16+0]);

  mov(ds, RED);
  mov(si, 0);
  lodsw();
  println(ax);

  set_row_col(13, 36); //row=0..49  //y.get(), x.get());
  mov(si, img_up); //img_ship[(frameCount/5)%24]);
  draw_sprite();

  //mov [cs:key.ctrl],al

  //mov(es,
  //mem(es,0);
}

void draw() {
  video.draw();
}

void loadAssets() {
  for (int i=0; i<24; i++) {
    img_ship[i] = incbin("data/ship-"+(((i+6)%24)+1)+".spr");
  }
  img_up = img_ship[18];
}

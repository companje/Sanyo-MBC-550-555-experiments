//import processing.sound.*;

PImage img;
int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int RED   = 0xf000;
int GREEN = 0x1c00;
int BLUE  = 0xf400;
int img_ship[] = new int[24];
int img_up;

Mem16 x = new Mem16();
Mem16 y = new Mem16();
Mem16 vx = new Mem16();
Mem16 vy = new Mem16();


PApplet app = this;

void setup() {
  size(640, 400);
  img = createImage(COLS*8, 200, RGB); //72*8=576

  for (int i=0; i<24; i++) img_ship[i] = incbin("data/ship-"+(((i+6)%24)+1)+".spr");
  img_up = img_ship[18];

  //ax.mov(36);
  //dx.mov(13);
  //bx.mov(x.getAddr());
  //v_set();
  
  x.mov(36);
  y.mov(13);
}

void draw() {
  set_cursor(y.get(), x.get());
  si.mov(img_up); //ship[(frameCount/5)%24]);
  draw_sprite();
  
  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    x.dec();
  } else if (key == 'd' || key == 'D') {
    x.inc();
  } else if (key == 'w') {
    y.dec();
  } else if (key == 's') {
    y.inc();
  }
}

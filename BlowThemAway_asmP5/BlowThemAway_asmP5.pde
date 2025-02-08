import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int ax, bx, cx, dx, si, di, bp; //chars are 16 bit unsigned in Java
PImage img_ship[] = new PImage[24];
PImage img_star[] = new PImage[3];

//zou dit met Java char moeten doen. Die is 16 bit unsigned.

int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int CENTER=COLS*LINES/2+COLS*4/2;

int mem[] = new int[10000]; //16 bits
int j=0; //increased by 2 for each dw()
int POS = dw(0);
int VEL = dw(0);
int VEL_SCALED = dw(0);
int ACC = dw(0);
int FORCE = dw(0);
int FORCES = dw(0);
int TMP = dw(0);
int ANGLE = dw(0);
int SPRITE_INDEX = dw(0);
int STARS=j+=2; //offset

int NUM_STARS=50;


void setup() {
  size(640, 400, P2D);
  textFont(loadFont("Ac437_SanyoMBC55x-12.vlw"));
  rectMode(CENTER);
  for (int i=0; i<24; i++) img_ship[i] = loadImage("ship-"+(((i+6)%24)+1)+".png");
  for (int i=0; i<img_star.length; i++) img_star[i] = loadImage("star-"+i+".png");

  mem[POS+0] = 73728/2;
  mem[POS+1] = 51200/2 - 10000;

  init_stars();

  //void v_from_angle() { //input ax=angle, input bx=mag, output ax=x, bx=y

  //for (int i=0; i<=360; i+=15) {
  //  ax=i;
  //  xy_from_angle();
  //  println(i, ax, bx); // ax=x, bx=y
  //}


  //mem[FORCE+0] = 300;
  //mem[FORCE+1] = 400;


  //println(ax);

  //addForceFromAngle(15);

  //copy(FORCE, FORCES); //dst, src
  //limit(FORCE, 25);
  //sub(FORCES, FORCE);
  //scale(FORCES, 90);
  //add(ACC, FORCE);
  //add(VEL, ACC);
  //clear(ACC);
  //add(POS, VEL);
  //scale(VEL, 98);


  //v_println("FORCE",FORCE);
  //v_println("FORCES", FORCES);
  //v_println("VEL",VEL);
  //v_println("POS",POS);

  //int ax = magSqScaled(FORCES);
  //println("mag scaled: " + ax);

  ////normalize(FORCE);
  ////v_print(FORCE);

  //println(magSq(FORCE));
  //println(mag(FORCE));  //sqrt(300*300+400*400)


  //exit();
}

void init_stars() {
  cx = NUM_STARS*2;
  do {
    bx = cx;
    mem[STARS+bx] = (int)random(0, 0xffff);
  } while (cx-->0);
}

void draw() {
  background(0);
  copy(FORCE, FORCES); //dst, src
  limit(FORCE, 25);
  sub(FORCES, FORCE);
  scale(FORCES, 90);
  add(ACC, FORCE);
  add(VEL, ACC);
  mult(ACC, 0);
  
  copy(VEL_SCALED, VEL); //dst, src
  //scale(VEL_SCALED,10);
  add(POS, VEL_SCALED);
  
  v_wrap(POS);
  
  scale(VEL, 98);

  if (magSq(VEL)>0) {
    ax = mem[VEL+0]; //vx
    bx = mem[VEL+1]; //vy
    atan2();
    //println(ax);
    mem[ANGLE] = ax;
    mem[SPRITE_INDEX] = mem[ANGLE]/15;
  }

  //println(mem[SPRITE_INDEX]);

  draw_stars();
  draw_ship();
  draw_debug_info();
}

void keyPressed() {
  int step=500;
  if (key=='w') addForceFromAngle(0); //mem[ANGLE], 5);
  if (key=='a') addForceFromAngle(-90); //mem[ANGLE]-90, 5);
  if (key=='d') addForceFromAngle(90); //mem[ANGLE]+90, 5);
  if (key=='s') {
    mult(FORCES, 0);
    mult(VEL, 64);
    div(VEL, 100);
  }
}

void addForceFromAngle(int angle) { //, int mag) {
  int mag = 5;
  ax = angle;
  ax += mem[ANGLE];
  xy_from_angle(); //ax=x, bx=y
  mem[FORCE+0] = ax;
  mem[FORCE+1] = bx;
  ax = mag;
  bx = FORCE;
  v_mult();
  add(FORCES, FORCE); //dst,src
  clear(FORCE); //force is tijdelijke var. Is toegevoegd aan FORCES
}

void draw_stars() {
  cx = NUM_STARS*2;
  do {
    bx = cx;
    ax = wrap_word(mem[STARS+bx+0] - mem[POS+0]); //x
    bx = wrap_word(mem[STARS+bx+1] - mem[POS+1]); //y
    world2screen();
    calc_di_from_bx();
    draw_img(img_star[2]);

    cx--; //extra
  } while (cx-->0);
}

void draw_ship() {
  set_cursor(16, 35);
  draw_img(img_ship[mem[SPRITE_INDEX]]);
}

void draw_debug_info() {
  int y=0;
  int step=12;

  fill(0, 255, 0);
  text("key: " + binary(key), 0, y+=step);
  text("frame: " + frameCount, 0, y+=step);
  text("x+: " + mem[POS], 0, y+=step);
  text("y+: " + mem[POS+1], 0, y+=step);
  text("vx: " + mem[VEL], 0, y+=step);
  text("vy: " + mem[VEL+1], 0, y+=step);
  text("vel.magSq: " + magSq(VEL), 0, y+=step);
  text("angle: " + mem[ANGLE], 0, y+=step);

  //  ; print "vel.magSq: "
  //  ; mov ax,[ship.vel.magSq]
  //  ; println_ax_unsigned

  //  print "angle: "
  //  mov ax,[ship.angle]
  //  println_ax

  //  ; print "index: "
  //  ; mov ax,[ship.sprite_index]
  //  ; println_ax

  //  ; print "img addr: "
  //  ; mov ax,[ship.img_addr]
  //  ; println_ax_hex

  //  print "force.x: "
  //  mov ax,[ship.force.x]
  //  println_ax

  //  print "force.y: "
  //  mov ax,[ship.force.y]
  //  println_ax

  //  print "forces.x: "
  //  mov ax,[ship.forces.x]
  //  println_ax

  //  print "forces.y: "
  //  mov ax,[ship.forces.y]
  //  println_ax
}

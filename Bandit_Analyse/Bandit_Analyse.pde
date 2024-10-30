int offset = 3120;
int count = 64;
//int X = 2;
//int nColors = 1;


byte bytes[];

int sw = 16;
int sh = 32;

void keyPressed() {
  if (key=='0') {offset = 0; count=16*8; }
  if (key=='1') {offset = 3120; count=8*8; }
  if (key=='2') {offset = 15438; count=8*4; }
  
  if (key=='[') offset--;
  if (key==']') offset++;
  //if (key=='x') X--;
  //if (key=='X') X++;
  //X = constrain(X, 0, 64);
  println(X);
}

void drawByte(int i, int x, int y) {
  if (i<0 || i+128>bytes.length-1) return;

  for (int xx=0; xx<8; xx++) {
    int bit = 128>>xx;
    int r = (bytes[128+i] & bit) > 0 ? 255 : 0;
    int g = (bytes[64+i] & bit) > 0 ? 255 : 0;
    int b = (bytes[0+i] & bit) > 0 ? 255 : 0;
    stroke(r, g, b);
    rect(x+xx, y, 1, 1);
  }
}

void clear(int offset, int count) {
  for (int i=offset; i<offset + count; i++) bytes[i] = 0;
}

void setup() {
  size(640, 640);
  bytes = loadBytes("BANDIT.EXE");

  //clear(3120, 64*192); //sprites
  //clear(0x7393, 5*192); //sprites
  //clear(15438, 40*192); //sprites
  clear(0x7753, 984); //strings
  clear(0x7E0A, 1656); //strings
  clear(0x6CF0, 1583); //strings
  clear(0x8BBB, 1167); //strings
  
  
  //offset = 0;

  //saveBytes("test.tmp", bytes);
  background(0);
  draw_sprites(0,0, 3120,8*8);
  draw_sprites(0,128, 15438,4*8);
  
  get(0,0,256,192).save("tmp.png"); 
  
  noLoop();
  noSmooth();
}

void draw_sprites(int xx, int yy, int offset, int count) {
  int hspacing = 0; //4
  int vspacing = 0; //2
  for (int r=0; r<count; r++) {
    int gridX = (r%8)*(32+hspacing);
    int gridY = (r/8)*(16+vspacing);
    int i=0;

    for (int y=0; y<4; y++) {
      for (int x=0; x<4; x++) { //x en y omgedraaid voor de test

        for (int q=0; q<4; q++, i++) {
          drawByte(
            offset  + i + r*192,
            xx + x*8 + gridX,
            yy + y*4 + q + gridY);
        }
      }
    }
  }
}


void draw() {
  //background(0);
  //scale(2, 4);

  

  //save("bandit1.png");
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  offset += e*16;

  offset = constrain(offset, 0, bytes.length-128);

  println(offset, hex(offset, 4));
}

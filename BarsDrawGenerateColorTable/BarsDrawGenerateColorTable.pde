PImage img, img2;
int si, di;
PGraphics pg;
int COLS=72;
int W=COLS*4;
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};
int colorTable[] = new int[256*4*4]; //256 colors, 4 line patterns per color, 3 color channels


void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);

  generateColorTable();
}

void calc_di(int x, int y) { //for cell, not pixel
  di = y * 288 + x * 4;
}


void generateColorTable() { //for 8x4px cells

  //int pattern_3bit[] = {
  //  0, 0, 0, 0,
  //  136, 0, 34, 0,
  //  170, 0, 170, 0,
  //  170, 17, 170, 68,
  //  170, 85, 170, 85,
  //  85, 238, 85, 187,
  //  119, 255, 221, 255,
  //  255, 255, 255, 255
  //};

  int pattern_2bit[] = {
    0, 0, 0, 0,
    68,17,68,17,    //±25p
    //170,0,170,0,
    //136,0,34,0,
    170, 85, 170, 85, //50p
    //255, 170, 255, 170,
    255, 255, 255, 255 };


  //BLUE (pattern 4x)
  //   RR GG BB
  //00 00 00 11 = 100%  3  pattern=pattern[3*4 + line_index] //always 255
  //00 00 00 10 =  66%  2  pattern=pattern[2*4 + line_index]
  //00 00 00 01 =  33%  1  pattern=pattern[1*4 + line_index]
  //00 00 00 00 =   0%  0  pattern=pattern[0*4 + line_index] //always 0

  //fill the colorTable with 256 colors x 3 color channels x 4 line bit-patterns (8x4px) per color = 3072 bytes

  //so every color needs 12 bytes
  for (int i=0; i<256; i++) {
    for (int c=0; c<3; c++) { //channel r=0, g=1, b=2
      for (int l=0; l<4; l++) { //4 lines
        int idx = i*12 + c*4 + l;
        int pidx = ((i>>(c*2)) & 3)*4 + l; //CHECKME....
        int pattern = pattern_2bit[pidx];
        //println("color="+i, binary(i,6), "channel="+c, "line="+l, "idx="+idx, "pattern (index="+pidx, "pattern="+pattern + ")"); //, "value="+pattern_2bit[rgb[c]*3 + l]);
        colorTable[idx] = pattern_2bit[pidx];
      }
    }
  }
}


void draw() {
  for (int y=0; y<4; y++) {
    for (int x=0; x<16; x++) {
      calc_di(x,y);
      println(di);

      al.set(y*16+x);
      si = al.get()*12;
      for (int c=0; c<3; c++) {
        for (int l=0; l<4; l++) {
          //println(hex(channels[c]), di + l, "=", colorTable[si]);
          mem[channels[c] + di + l] = colorTable[si];
          si++;
        }
      }
    }
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
  noLoop();
}

//  //drawLine(0,0,255);
//  bl.set(x);
//  bh.set(y);
//  dl.set(1);
//  dh.set(1);
//  calc_di_from_bx();
//  fillCells();


//}

//void drawLine(int di, int ch, int v) {
//  for (int i = 0; i < COLS*4; i+=4) { //was i<COLS*4
//    mem[channels[ch] + di + i] = v;
//  }
//}

void keyPressed() {
  noLoop();
}

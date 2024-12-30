int offset = 0x5a50;
int count = 64;
//int X = 2;
//int nColors = 1;
byte bytes[];

int sw = 16;
int sh = 32;

void keyPressed() {
  if (key=='0') {
    offset = 0;
    count=16*8;
  }
  if (key=='1') {
    offset = 3120;
    count=8*8;
  }
  if (key=='2') {
    offset = 15438;
    count=8*4;
  }
  if (key=='3') {
    offset = 0x5a50;
    count=8*8;
  }
  if (key=='[') offset--;
  if (key==']') offset++;
  //if (key=='x') X--;
  //if (key=='X') X++;
  //X = constrain(X, 0, 64);
  println(X);
}

//void drawByte(int i, int x, int y, int channels) {
//  if (i<0 || i+128>bytes.length-1) return;

//  for (int xx=0; xx<8; xx++) {
//    int bit = 128>>xx;

//    if (channels==3) {
//      int r = (bytes[128+i] & bit) > 0 ? 255 : 0; //dit werkt alleen wanneer de sprite 192 bytes in neemt
//      int g = (bytes[64+i] & bit) > 0 ? 255 : 0;
//      int b = (bytes[0+i] & bit) > 0 ? 255 : 0;
//      stroke(r, g, b);
//    } else if (channels==1) {
//      stroke((bytes[0+i] & bit) > 0 ? 255 : 0);
//    }
//    rect(x+xx, y, 1, 1);
//  }
//}



void clear(int offset, int count) {
  for (int i=offset; i<offset + count; i++) bytes[i] = 0;
}

void clear_from_to(int from, int to) {
  for (int i=from; i<=to; i++) bytes[i] = 0;
}

void setup() {
  size(640, 1000);
  bytes = loadBytes("BANDIT.EXE");


  clear(3120, 64*192); //sprites: sleutel tot poppetje
  clear(15438, 40*192); //sprites: donut tot schorpioen

  //clear(0x7393, 5*192); //sprites:
  clear(0x7753, 984); //strings
  clear(0x7E0A, 1656); //strings
  clear(0x6CF0, 1583); //strings
  clear(0x8BBB, 1167); //strings

  clear_from_to(0, 20); //MZ header
  clear_from_to(0x3c20, 0x3c4e); //0+NCN@NLNONRNUNFNI01
  clear_from_to(0x627a, 0x6292); //1234567890123456789012345
  clear_from_to(0x7393, 0x7752); //TREES, CACTI, THE TIMEGATES ...

  clear_from_to(0x0297, 0x0318); //code
  clear_from_to(0x08d1, 0x0b64); //code
  clear_from_to(0x84a1, 0x8918); //code
  clear_from_to(0x90db, 0x911a); //code
  clear_from_to(0x914a, 0xaf96); //code

  clear_from_to(0xaf96, 0xafa8); //string?

  saveBytes("bandit-zonder-code.exe", bytes);

  //offset = 0;

  //saveBytes("test.tmp", bytes);
  background(0);
  //draw_sprites(0,128, 15438, 5*8); //8*192

  //get(0,0,256,208).save("tmp.png");

  //noLoop();
  noSmooth();
}

void drawByte(int i, int x, int y, int channels) {
  if (i<0 || i+128>bytes.length-1) return;
  for (int xx=0; xx<8; xx++) {
    int bit = 128>>xx;
    stroke((bytes[0+i] & bit) > 0 ? 255 : 0);
    rect(x+xx, y, 1, 1);
  }
}

void draw_sprites(int xx, int yy, int offset, int count, int channels) {
  int expected_bytes_per_font_letter = 32; //2x4 cols 4 rows - 8 dots horizontal per col
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
            offset  + i + r*192/2/3,
            xx + x*4+ gridX,
            yy + y*4 + q + gridY,
            channels); //channels
        }
      }
    }
  }
}


void draw() {
  background(0);
  scale(5, 10);

  draw_sprites(0, 0, offset, 64*8, 1);

  //int channels = 1;
  //int i=offset;
  //int x=0;
  //int y=0;

  ////for (int p=0; p<32; p++) {
  //drawByte(i++, x++, y, channels);
  //drawByte(i++, x+=8, y, channels);
  //y+=2;
  //x=0;
  //drawByte(i++, x++, y, channels);
  //drawByte(i++, x+=8, y, channels);
  //y+=2;
  //x+=16;  
  //drawByte(i++, x++, y, channels);
  //drawByte(i++, x+=8, y, channels);
  


}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  offset += e*16;

  offset = constrain(offset, 0, bytes.length-128);

  println(offset, "0x"+hex(offset, 4));

  //1152 0x480
  //992
}

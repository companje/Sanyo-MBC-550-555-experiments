PImage img, img2;
PGraphics pg;
int COLS=80;
int ROWS=50;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int mem[] = new int[1024*1024];
int R=0xf0000, G=0x0C000, B=0xf4000;

int intensity[][] = { {0, 0, 0, 0}, {136, 0, 34, 0}, {170, 0, 170, 0}, {170, 17, 170, 68}, {170, 85, 170, 85}, {85, 238, 85, 187}, {119, 255, 221, 255}, {255, 255, 255, 255}};
//int intensity[][] = { {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 4}, {0, 0, 0, 16}, {0, 0, 0, 136}, {0, 0, 0, 137}, {0, 0, 4, 32}, {0, 0, 8, 0}, {0, 0, 66, 0}, {0, 0, 17, 0}, {0, 0, 17, 0}, {0, 0, 18, 0}, {0, 0, 73, 0}, {0, 0, 36, 0}, {0, 0, 146, 0}, {0, 0, 73, 0}, {0, 8, 32, 1}, {0, 66, 0, 17}, {0, 16, 0, 34}, {0, 132, 0, 34}, {0, 68, 0, 34}, {0, 68, 0, 34}, {0, 68, 0, 34}, {0, 146, 0, 1}, {0, 73, 0, 2}, {0, 36, 0, 17}, {0, 146, 0, 17}, {0, 73, 0, 18}, {0, 36, 0, 73}, {0, 146, 0, 36}, {0, 73, 0, 146}, {0, 36, 0, 73}, {0, 146, 0, 36}, {0, 73, 0, 165}, {0, 37, 0, 41}, {0, 74, 0, 36}, {0, 170, 0, 68}, {0, 170, 0, 68}, {0, 170, 0, 68}, {0, 170, 0, 68}, {0, 170, 0, 146}, {0, 170, 0, 73}, {0, 170, 0, 36}, {0, 170, 0, 146}, {0, 170, 0, 82}, {0, 170, 0, 149}, {2, 168, 1, 82}, {4, 161, 8, 37}, {16, 68, 17, 34}, {132, 34, 16, 69}, {33, 72, 4, 81}, {8, 146, 33, 8}, {66, 36, 8, 146}, {17, 136, 68, 34}, {17, 136, 68, 34}, {17, 136, 68, 34}, {17, 136, 68, 34}, {17, 136, 68, 34}, {17, 136, 68, 73}, {17, 136, 68, 41}, {17, 136, 146, 36}, {17, 136, 73, 146}, {36, 136, 37, 16}, {146, 68, 34, 72}, {73, 34, 145, 72}, {36, 17, 72, 146}, {146, 8, 164, 73}, {73, 146, 68, 34}, {36, 73, 34, 145}, {146, 36, 17, 74}, {73, 146, 36, 66}, {36, 73, 146, 68}, {146, 36, 73, 146}, {73, 146, 36, 73}, {36, 73, 146, 36}, {146, 36, 73, 146}, {73, 146, 36, 73}, {36, 73, 146, 73}, {146, 37, 146, 41}, {73, 36, 82, 36}, {36, 146, 169, 68}, {146, 73, 84, 137}, {73, 84, 137, 82}, {36, 170, 17, 170}, {146, 84, 36, 146}, {148, 165, 146, 73}, {165, 41, 74, 81}, {41, 74, 82, 36}, {74, 82, 148, 73}, {82, 148, 165, 40}, {165, 82, 149, 72}, {85, 34, 153, 74}, {85, 34, 153, 74}, {85, 34, 173, 64}, {85, 34, 173, 64}, {85, 34, 173, 66}, {85, 73, 85, 73}, {85, 36, 85, 41}, {85, 164, 42, 83}, {85, 164, 85, 42}, {85, 164, 85, 74}, {85, 170, 68, 182}, {85, 170, 68, 182}, {85, 170, 73, 181}, {85, 170, 36, 85}, {85, 170, 148, 101}, {85, 170, 149, 105}, {85, 170, 85, 36}, {85, 170, 85, 146}, {85, 170, 85, 146}, {85, 170, 85, 170}, {85, 170, 85, 169}, {171, 84, 171, 36}, {90, 165, 90, 146}, {214, 41, 214, 73}, {181, 74, 181, 74}, {173, 82, 173, 82}, {107, 148, 107, 148}, {109, 146, 109, 146}, {182, 73, 182, 73}, {219, 36, 219, 36}, {109, 146, 109, 146}, {182, 73, 182, 73}, {219, 36, 219, 85}, {109, 146, 109, 85}, {182, 73, 182, 85}, {219, 36, 247, 18}, {109, 165, 90, 173}, {182, 74, 182, 85}, {219, 84, 219, 74}, {109, 170, 85, 219}, {182, 170, 85, 109}, {219, 170, 85, 187}, {109, 170, 85, 187}, {182, 170, 109, 85}, {219, 170, 109, 171}, {109, 181, 86, 106}, {182, 90, 213, 173}, {219, 173, 213, 54}, {109, 182, 74, 247}, {182, 219, 85, 182}, {238, 51, 173, 106}, {238, 51, 173, 218}, {238, 51, 173, 218}, {238, 53, 219, 84}, {238, 85, 187, 204}, {238, 85, 187, 204}, {238, 85, 187, 213}, {238, 85, 187, 85}, {238, 85, 187, 85}, {247, 89, 174, 117}, {189, 86, 235, 181}, {239, 89, 222, 101}, {125, 166, 219, 109}, {247, 154, 119, 170}, {223, 105, 183, 218}, {126, 165, 123, 173}, {255, 145, 127, 164}, {255, 17, 255, 146}, {255, 17, 255, 74}, {255, 36, 255, 73}, {255, 146, 255, 36}, {255, 73, 255, 146}, {255, 36, 255, 73}, {255, 146, 255, 36}, {255, 73, 255, 148}, {255, 36, 255, 165}, {255, 146, 255, 85}, {255, 73, 255, 85}, {255, 36, 255, 85}, {255, 146, 255, 85}, {255, 82, 255, 85}, {255, 148, 255, 85}, {255, 165, 255, 85}, {255, 42, 255, 85}, {255, 85, 254, 87}, {255, 85, 254, 87}, {255, 85, 255, 101}, {255, 85, 255, 42}, {255, 85, 255, 170}, {255, 85, 255, 170}, {255, 85, 255, 170}, {255, 85, 255, 170}, {255, 85, 255, 181}, {255, 90, 247, 189}, {255, 214, 189, 239}, {255, 181, 255, 86}, {255, 182, 123, 222}, {255, 219, 239, 187}, {255, 109, 191, 117}, {255, 182, 255, 85}, {255, 219, 255, 85}, {255, 109, 255, 85}, {255, 182, 255, 85}, {255, 219, 255, 173}, {255, 109, 255, 182}, {255, 182, 255, 219}, {255, 219, 255, 109}, {255, 119, 239, 189}, {255, 119, 255, 173}, {255, 119, 255, 109}, {255, 123, 223, 251}, {255, 222, 123, 255}, {255, 247, 222, 255}, {255, 190, 247, 254}, {255, 255, 218, 255}, {255, 255, 214, 255}, {255, 255, 182, 255}, {255, 255, 219, 255}, {255, 255, 109, 255}, {255, 255, 182, 255}, {255, 255, 219, 255}, {255, 255, 109, 255}, {255, 255, 182, 255}, {255, 255, 219, 255}, {255, 255, 110, 255}, {255, 255, 239, 255}, {255, 255, 123, 255}, {255, 255, 223, 253}, {255, 255, 255, 182}, {255, 255, 255, 219}, {255, 255, 255, 109}, {255, 255, 255, 183}, {255, 255, 255, 119}, {255, 255, 255, 123}, {255, 255, 255, 223}, {255, 255, 255, 126}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255}, {255, 255, 255, 255} };

void setup() {
  size(640, 400);

  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height); //img.width, img.height); //fbo
}

void setCell(int row, int col, int b, int channel) {
  b = constrain(b/32, 0, 7); //deze regel kan uit bij 255 resolutie
  for (int i=0; i<4; i++) {
    mem[channel+row*COLS*4 + col*4 + i] = intensity[b][i];
  }
}

void setCellRed(int row, int col, int b) {
  setCell(row, col, b, R);
}

void setCellGreen(int row, int col, int b) {
  setCell(row, col, b, G);
}
void setCellBlue(int row, int col, int b) {
  setCell(row, col, b, B);
}

void draw() {
  //green
  for (int row=0; row<ROWS; row++) {
    for (int col=0; col<COLS; col++) {
      //int b = int(float(col)/COLS*255);
      float cx = COLS/2 + sin(frameCount*.1)*5;
      float cy = ROWS/2 + cos(frameCount*.1)*5;
      int b = int(map(dist(row, col, cy, cx), 0, 48, 0, 255));
      setCellGreen(row, col, int(map(sin(-frameCount*.25+b/48.*TWO_PI), -1, 1, 0, 255)));
      
      //cx = COLS/2 + sin(frameCount*.1)*10;
      //cy = ROWS/2 + cos(frameCount*.1)*10;
      //b = int(map(dist(row, col, cy, cx), 0, 48, 0, 255));
      //setCellRed(row, col, int(map(sin(-frameCount*.25+b/48.*TWO_PI), -1, 1, 0, 255)));
      
      //cx = COLS/2 + sin(frameCount*.1)*15;
      //cy = ROWS/2 + cos(frameCount*.1)*15;
      //b = int(map(dist(row, col, cy, cx), 0, 48, 0, 255));
      //setCellBlue(row, col, int(map(sin(-frameCount*.25+b/48.*TWO_PI), -1, 1, 0, 255)));
    }
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);

  save("tmp.png");
}

void keyPressed() {
  if (key=='c') clearAll();
}

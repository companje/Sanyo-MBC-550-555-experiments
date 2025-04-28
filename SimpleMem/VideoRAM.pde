int COLS=72;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int RED   = 0xf000;
int GREEN = 0x1c00;
int BLUE  = 0xf400;

class VideoRAM {
  PImage img;

  void setup() {
    img = createImage(COLS*8, 200, RGB); //72*8=576
  }

  void draw() {
    setImageFromMemory(img);
    image(img, 0, 0, width, height);
  }
}

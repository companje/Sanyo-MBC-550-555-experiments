int chars[] = {
  0, 0, 0, 0,
  0, 0, 0, 1,
  0, 0, 0, 3,
  0, 0, 1, 3,
  0, 0, 3, 7,
  0, 0, 7, 15,
  0, 3, 15, 31,
  0, 7, 31, 63,
  1, 15, 63, 63,
  3, 31, 63, 63,
  7, 31, 63, 127,
  7, 31, 127, 127,
  7, 63, 127, 127,
  15, 63, 127, 127,
  15, 63, 127, 255,
  31, 127, 255, 255
};

void setup() {
  size(800, 200);
  noSmooth();
  background(0);
  //scale(2, 4);

  //kan ook met rotate en/of scale(flip) dit doen
  for (int i=0; i<chars.length; i++) {

    drawByte((i/4)*16+8, i%4, chars[i]);
    drawByte((i/4)*16, i%4, flipBits(chars[i]));

    if (i%4<3) {
      drawByte((i/4)*16+8, 6+((4-i)%4), chars[i]);
      drawByte((i/4)*16, 6+((4-i)%4), flipBits(chars[i]));
    }
  }
 
  get(0,0,16*16,8).save("tixy-dots.png");
}

void draw() {
}

byte flipBits(int b) {
  byte result = 0;
  for (int i = 0; i < 8; i++) {
    result |= ((b >> i) & 1) << (7 - i);
  }
  return result;
}


void drawByte(int x, int y, int b) {
  for (int q=0; q<8; q++) {
    color c = (b & (1<<q)) != 0 ? color(255) : color(0);
    stroke(c);
    rect(x+q, y, 1, 1);
  }
}

byte bytes[];
int COLS=72, ROWS=50;

void setup() {
  noSmooth();
  size(576, 400);
  //bytes = loadBytes("/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/data/box.bin");
  bytes = loadBytes("/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/data/full.bin");
  //PImage img = getImageFromBytes(bytes, 32, 16); //in pixels!
  PImage img = getImageFromBytes(bytes, 18*8, 4*4); //in pixels!
  //PImage img = loadImage("dots144x16.png");
  scale(5, 10);
  //scale(1,2);
  image(img, 0, 0);
}

void draw() {
}

PImage getImageFromBytes(byte[] bytes, int w, int h) { //w,h in pixels - 3 channel image
  PImage img = createImage(w, h, RGB);
  img.loadPixels();
  for (int y=0, bit=128, j=0; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8)) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (bytes[i+0*w/8*h] & bit)>0 ? 255 : 0;
      int g = (bytes[i+1*w/8*h] & bit)>0 ? 255 : 0;
      int b = (bytes[i+2*w/8*h] & bit)>0 ? 255 : 0;
      img.pixels[j++] = color(r, g, b);
      //println(r, g, b);
    }
  }
  img.updatePixels();
  return img;
}

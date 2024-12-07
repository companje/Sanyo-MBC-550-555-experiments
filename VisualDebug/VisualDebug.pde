byte b[];
long timeStamp;
File file;
String filename = "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/Bootpic2/memory.bin";

void setup() {
  noSmooth();
  size(1024, 1024);
  frameRate(60);
  file = new File(dataPath(filename));

  reload();
}

void draw() {
  if (frameCount%10==0 && file.lastModified()!=timeStamp) {
    println("reload");
    reload();
  };

  loadPixels();
  for (int i=0; i<b.length; i++) {
    pixels[i] = color(b[i]&255);
  }
  updatePixels();

  if (b.length>0) {
    image(getImageFromBytes(b, 0x667 + mouseX, 32, 16), 0, 100);
  }
}

void keyPressed() {
  if (key=='r') reload();
}

void reload() {
  b = loadBytes(filename);
}

PImage getImageFromBytes(byte[] bytes, int offset, int w, int h) { //w,h in pixels - 3 channel image
  PImage img = createImage(w, h, RGB);
  img.loadPixels();
  for (int y=0, bit=128, j=0; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8)) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4 + offset;
      int r = (bytes[i+0*w/8*h] & bit)>0 ? 255 : 0;
      int g = (bytes[i+1*w/8*h] & bit)>0 ? 255 : 0;
      int b = (bytes[i+2*w/8*h] & bit)>0 ? 255 : 0;
      img.pixels[j++] = color(r, g, b);
    }
  }
  img.updatePixels();
  return img;
}

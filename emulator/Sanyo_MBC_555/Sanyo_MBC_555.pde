Intel8086 cpu = new Intel8086();
PImage img;

void setup() {
  size(825, 640);
  frameRate(60);
  img = createImage(640, 200, RGB); //72*8=576
  reload();
}

void tick() {
  try {
    while (cpu.tick());
    println("done");
  }
  catch (final Exception e) {
    e.printStackTrace();
  }
}

void reload() {
  cpu.halt = true;
  cpu.reset();
  cpu.load(0x00380, loadBytes("0001-mbc555-bootsector.img"));
  cpu.cs = 0x0038;
  cpu.halt = false;
  thread("tick");
}

void draw() {
  if (frameCount%300==0) {
    reload();
  }

  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*(img.width/2)+(y%4)+int(x/8)*4;
      int r = (cpu.memory[0xf0000+i] & bit)>0 ? 255 : 0;
      int g = (cpu.memory[0x0c000+i] & bit)>0 ? 255 : 0;
      int b = (cpu.memory[0xf4000+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
  image(img, 0, 0, width, height);
}

void mousePressed() {
  reload();
}

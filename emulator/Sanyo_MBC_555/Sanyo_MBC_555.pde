Intel8086 cpu = new Intel8086();
PImage img;
int cols=72;

void setup() {
  //noSmooth();
  size(825, 550);
  frameRate(10);
  surface.setLocation(855, 0);
  img = createImage(cols*8, 200, RGB); //72*8=576
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
  for (int i=0; i<cpu.memory.length; i++) {
    cpu.memory[i] = 0;
  }
  cpu.load(0xfc000, loadBytes("MBC-555.ROM"));
  //jmp naar: 0xFE00*16+0x1E00
  
  cpu.load(0x00380, loadBytes("0001-mbc555-bootsector.img"));
  cpu.cs = 0x0038;
  cpu.halt = false;
  thread("tick");
}

void draw() {
  //scale(1.5);
  if (frameCount%60==0) reload();
  
  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*(img.width/2)+(y%4)+int(x/8)*4;
      int r = (cpu.getMem(cpu.B,0xf0000+i) & bit)>0 ? 255 : 0;
      int g = (cpu.getMem(cpu.B,0x0c000+i) & bit)>0 ? 255 : 0;
      int b = (cpu.getMem(cpu.B,0xf4000+i) & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r,g,b); //lerpColor(color(r, g, b), color(100,255,0), .2);
    }
  }
  
  img.updatePixels();
  image(img, 0, 0, width, height);
  
  //vlines
  for (int y=0; y<height; y+=height/200.) {
    stroke(0,50);
    line(0,y,width,y);
  }
  
  if (frameCount<20) {
    saveImage();
  }
}

void mousePressed() {
  saveImage();
  reload();
}

void saveImage() {
  get().save("frames/"+(year()+nf(month(), 2)+nf(day(), 2)+"-"+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2)+"."+millis())+".jpg");
}

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.BasicFileAttributes;

int int3_counter = 0;
int memory[] = new int[0x200000]; ///HACK was 0x100000=1048576
Intel8086 cpu = new Intel8086();
int greenOffset = 0x0c000;
PApplet app=this;
PImage img;
int cols=72;
long timeStamp;
File file;
String filename="game-of-life.img";


void setup() {
  file = new File(dataPath(filename));

  noSmooth();
  size(576, 400, P3D);

  frameRate(1);
  textFont(loadFont("CourierNewPSMT-18.vlw"));
  surface.setLocation(0, 0); //840, 620);
  img = createImage(cols*8, 200, RGB); //72*8=576
  reload();
}

void reload() {
  int3_counter = 0;
  frameCount = 1; //ok?

  timeStamp = file.lastModified();
  cpu.reset();
  for (int i=0; i<memory.length; i++) {
    memory[i] = int(random(256));
  }

  byte rom[] = loadBytes("MBC-555.ROM");

  //load(0xFC000, rom);
  //load(0x2000, rom);
  //load(0x4000, rom);

  load(0xFE000, rom);

  load_max(0x00380, loadBytes(filename), 512); //more than bootsector to test code

  cpu.ah = cpu.al = cpu.bh = cpu.bl = 0;
  cpu.ch = cpu.cl = cpu.dh = cpu.dl = 0;
  cpu.si = 0;
  cpu.di = 0;
  cpu.cs = 0xfe00; //0x0038;
  cpu.ip = 0x1e00;

  //println(hex(rom[0x1e00]));
  //println(hex(memory[0xfe000 + 0x1e00], 2));
  //println(hex(memory[0xfe000 + 0x1e42], 2));

  //System.exit(0);

  cpu.ss = 0x0be4;
  cpu.sp = 0x0000;
  cpu.halt = false;
}

void draw() {

  //if (true) return;

  if (frameCount%10==0 && file.lastModified()!=timeStamp) {
    println("reload");
    reload();
  };

  try {
    for (int i=0; i<1 && cpu.tick(); i++);
  }
  catch (Exception e) {
    println("exception", e);
  }

  pushMatrix();

  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*(img.width/2)+(y%4)+int(x/8)*4;
      int r = (memory[0xf0000+i] & bit)>0 ? 255 : 0;
      int g = (memory[greenOffset+i] & bit)>0 ? 255 : 0;
      int b = (memory[0xf4000+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();

  pushMatrix();
  float hscale=1; //1.3; //2; //1.5;
  float vscale=1; //1.3; //2; //1.5;
  float ratio=1; //1.2; //1.7;
  //scale(3);
  scale(hscale, vscale);
  image(img, 0, 0, width, height); //width*scale*ratio, height*scale);
  popMatrix();

  //vlines raster
  //for (int y=0; y<height; y+=height/200.) {
  //  stroke(0, 150);
  //  float yy=y+.5;
  //  //strokeWeight(1.5);
  //  line(0, yy, width, yy);
  //}

  noStroke();
  pushMatrix();
  translate(width-100, height-250);
  int ystep=18;
  int y=5;
  fill(0);
  text2("AX:"+hex(cpu.ah, 2)+""+hex(cpu.al, 2), 10, y+=ystep);
  text2("BX:"+hex(cpu.bh, 2)+""+hex(cpu.bl, 2), 10, y+=ystep);
  text2("CX:"+hex(cpu.ch, 2)+""+hex(cpu.cl, 2), 10, y+=ystep);
  text2("DX:"+hex(cpu.dh, 2)+""+hex(cpu.dl, 2), 10, y+=ystep);
  text2("SS:"+hex(cpu.ss, 4), 10, y+=ystep);
  text2("SP:"+hex(cpu.sp, 4), 10, y+=ystep);
  text2("DS:"+hex(cpu.ds, 4), 10, y+=ystep);
  text2("ES:"+hex(cpu.es, 4), 10, y+=ystep);
  text2("BP:"+hex(cpu.bp, 4), 10, y+=ystep);
  text2("SI:"+hex(cpu.si, 4), 10, y+=ystep);
  text2("DI:"+hex(cpu.di, 4), 10, y+=ystep);
  text2("CS:"+hex(cpu.cs, 4), 10, y+=ystep);
  text2("IP:"+hex(cpu.ip, 4), 10, y+=ystep);
  popMatrix();

  popMatrix();

  if (frameCount<20) {
    saveImage();
  }
}

void text2(String s, float x, float y) {
  fill(255);
  rect(x-5, y-18, textWidth(s)+13, 24);
  fill(0);
  text(s, x, y);
}

void mousePressed() {
  cpu.halt = false; //resume
}

void keyPressed() {
  if (key=='r') reload();
  if (key==' ') cpu.halt=!cpu.halt;
}

void saveImage() {
  get().save("frames/"+(year()+nf(month(), 2)+nf(day(), 2)+"-"+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2)+"."+millis())+".jpg");
}

int portIn(final int w, final int port) {
  println("portIn", w, port);

  if (port==0x22) {
    return int(millis());
  }

  if (port==0x10) {
    if (greenOffset==0x0C000) return 4;
    if (greenOffset==0x1C000) return 5;
    if (greenOffset==0x2C000) return 6;
    if (greenOffset==0x3C000) return 7;
  }
  //for (final Peripheral peripheral : peripherals)
  //  if (peripheral.isConnected(port))
  //    return peripheral.portIn(w, port);
  return 0;
}


void portOut(final int w, final int port, final int val) {
  println("out(0x"+hex(port, 2) + ", 0x" + hex(val, 2)+")");

  if (port==0x10) {
    if (val==4) greenOffset=0x0C000;
    if (val==5) greenOffset=0x1C000;
    if (val==6) greenOffset=0x2C000;
    if (val==7) greenOffset=0x3C000;
  }

  //for (final Peripheral peripheral : peripherals)
  //  if (peripheral.isConnected(port)) {
  //    peripheral.portOut(w, port, val);
  //    return;
  //  }
}

public void load_max(int addr, byte bin[], int maxBytes) {
  for (int i = 0; i < min(bin.length, maxBytes); i++)
    memory[addr + i] = bin[i] & 0xff;
}

public void load(int addr, byte bin[]) { // throws IOException {
  for (int i = 0; i < bin.length; i++)
    memory[addr + i] = bin[i] & 0xff;
}

void debugPrint(String msg) {
  println(msg);
}

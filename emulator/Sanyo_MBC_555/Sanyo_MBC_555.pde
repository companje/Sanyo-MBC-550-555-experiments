import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.BasicFileAttributes;

Intel8086 cpu = new Intel8086();
PApplet app=this;
PImage img;
int cols=72;
long timeStamp;
File file;
String filename="/Users/rick/Sanyo/Sanyo-MBC-550-555-repo/emulator/Sanyo_MBC_555/data/tixyboot.img";
//String filename="/Users/rick/Sanyo/Sanyo-MBC-550-555-repo/bootsector-experiments/tixyboot.img";

void setup() {
  file = new File(dataPath(filename));

  noSmooth();
  //size(1152, 800);
  size(576, 400);

  frameRate(60);
  textFont(loadFont("CourierNewPSMT-18.vlw"));
  surface.setLocation(755, 0);
  img = createImage(cols*8, 200, RGB); //72*8=576
  reload();
}

void reload() {
  frameCount = 1; //kan dit?

  timeStamp = file.lastModified();
  cpu.reset();
  for (int i=0; i<cpu.memory.length; i++) {
    cpu.memory[i] = 0; //int(random(256));
  }
  cpu.load_max(0x00380, loadBytes(filename), 1024); //more than bootsector to test code
  cpu.cs = 0x0038;
  cpu.ss = 0x0be4;
  cpu.sp = 0x0000;
  cpu.halt = false;
}

//  //cpu.load(0xfc000, loadBytes("MBC-555.ROM"));
//  //jmp naar: 0xFE00*16+0x1E00
//  cpu.load(0x00380, loadBytes("0001-mbc555-bootsector.img"));
//  cpu.cs = 0x0038;
//  cpu.halt = false;
//  //thread("tick");
//}

void draw() {
  if (frameCount%10==0 && file.lastModified()!=timeStamp) {
    println("reload");
    reload();
  };

  try {
    for (int i=0; i<5000 && cpu.tick(); i++);
  }
  catch (Exception e) {
    println("exception",e);
  }

  pushMatrix();

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

  pushMatrix();
  float hscale=1; //1.3; //2; //1.5;
  float vscale=1; //1.3; //2; //1.5;
  float ratio=1; //1.2; //1.7;
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
  //fill(255);
  //rect(5, 5, 90, 12*ystep+6);
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

  for (int i=0; i<200; i++) {
    //text2(hex(cpu.memory[0x00380+i],2),10+(i%16)*38,100+(i/16)*27);
  }
  
  //rect(0,0,100,100);

  popMatrix();

  if (frameCount<20) {
    saveImage();
  }
}

void text2(String s, float x, float y) {
  fill(255);
  rect(x-5,y-18,textWidth(s)+13,24);
  fill(0);
  text(s,x,y);  
}

void mousePressed() {
  //saveImage();
  //reload();
  cpu.halt = false; //resume
}

void keyPressed() {
  if (key=='r') reload();
  if (key==' ') cpu.halt=!cpu.halt;
}

void saveImage() {
  get().save("frames/"+(year()+nf(month(), 2)+nf(day(), 2)+"-"+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2)+"."+millis())+".jpg");
}

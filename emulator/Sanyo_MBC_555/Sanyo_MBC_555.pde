//import java.util.*;
//import java.io.*;
//import java.nio.*;
//import java.nio.file.Files;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.BasicFileAttributes;

Intel8086 cpu = new Intel8086();
PImage img;
int cols=80;
long timeStamp;
File file;
//FileTime creationTime;
String filename="0001-mbc555-bootsector.img";

void setup() {
  file = new File(dataPath(filename));

  noSmooth();
  size(800, 450);
  frameRate(60);
  textFont(loadFont("CourierNewPSMT-18.vlw"));
  surface.setLocation(855, 0);
  img = createImage(cols*8, 200, RGB); //72*8=576
  reload();
}

void reload() {
  timeStamp = file.lastModified();
  cpu.reset();
  for (int i=0; i<cpu.memory.length; i++) {
    cpu.memory[i] = int(random(256));
  }
  cpu.load(0x00380, loadBytes(filename));
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

  for (int i=0; i<100 && cpu.tick(); i++);

  //cpu.tick();
  pushMatrix();

  //if (frameCount%30==0) reload();

  img.loadPixels();
  for (int y=0, bit=0, j=0; y<img.height; y++) {
    for (int x=0; x<img.width; x++, bit=128>>(x%8), j++) {
      int i=int(y/4)*(img.width/2)+(y%4)+int(x/8)*4;
      int r = (cpu.memory[0xf0000+i] & bit)>0 ? 255 : 0;
      int g = (cpu.memory[0x0c000+i] & bit)>0 ? 255 : 0;
      int b = (cpu.memory[0xf4000+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g+i, b);
    }
  }
  img.updatePixels();
  float scale=4; 
  float ratio=1.7;
  image(img, 0, 0, width*scale*ratio, height*scale);

  //vlines
  //for (int y=0; y<height; y+=height/200.) {
  //  stroke(0, 50);
  //  line(0, y, width, y);
  //}

  noStroke();
  translate(width-100, 0);
  int ystep=18;
  int y=5;
  fill(255);
  rect(5, 5, 90, 12*ystep+6);
  fill(0);

  text("AX:"+hex(cpu.al, 2)+""+hex(cpu.ah, 2), 10, y+=ystep);
  text("BX:"+hex(cpu.bl, 2)+""+hex(cpu.bh, 2), 10, y+=ystep);
  text("CX:"+hex(cpu.cl, 2)+""+hex(cpu.ch, 2), 10, y+=ystep);
  text("DX:"+hex(cpu.dl, 2)+""+hex(cpu.dh, 2), 10, y+=ystep);
  text("SS:"+hex(cpu.ss, 4), 10, y+=ystep);
  text("SP:"+hex(cpu.sp, 4), 10, y+=ystep);
  text("DS:"+hex(cpu.ds, 4), 10, y+=ystep);
  text("ES:"+hex(cpu.es, 4), 10, y+=ystep);
  text("BP:"+hex(cpu.bp, 4), 10, y+=ystep);
  text("SI:"+hex(cpu.si, 4), 10, y+=ystep);
  text("DI:"+hex(cpu.di, 4), 10, y+=ystep);
  text("IP:"+hex(cpu.ip, 4), 10, y+=ystep);

  popMatrix();
  if (frameCount<20) {
    saveImage();
  }
}

void mousePressed() {
  saveImage();
  reload();
}

void keyPressed() {
  if (key==' ') cpu.tick();
  if (key=='r') reload();
}
//  saveImage();
//  reload();
//}

void saveImage() {
  get().save("frames/"+(year()+nf(month(), 2)+nf(day(), 2)+"-"+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2)+"."+millis())+".jpg");
}

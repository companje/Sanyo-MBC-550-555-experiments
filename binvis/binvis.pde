int[] memory = new int[0x200000];
byte[] file;
int cs, es, ds;
PImage img;
int offset = 0;
int COLS = 72;
int LINES = 200;
int RED=0xf0000, GREEN=0xC000, BLUE=0xf4000;

void settings() {
  noSmooth();
  size(1152, 850);
}

void setup() {
  img = createImage(576, 200, RGB);
  file = loadBytes("BANDIT.EXE");
  clear(file, 0x0C30, 64*192); //sprites: sleutel tot poppetje
  //clear(file, 0x3C4E, 40*192); //sprites: donut tot schorpioen
  clear(file, 0x7753, 984);    //strings
  clear(file, 0x7E0A, 1656);   //strings
  clear(file, 0x6CF0, 1583);   //strings
  clear(file, 0x8BBB, 1167);   //strings
  clear(file, 0x0000, 20);     //MZ header
  clear(file, 0x3C20, 0x002E); //0+NCN@NLNONRNUNFNI01
  clear(file, 0x627A, 0x0018); //1234567890123456789012345
  clear(file, 0x7393, 0x03BF); //TREES, CACTI, THE TIMEGATES ...
  clear(file, 0x0297, 0x0081); //code
  clear(file, 0x08D1, 0x0293); //code
  clear(file, 0x84A1, 0x0477); //code
  clear(file, 0x90DB, 0x003F); //code
  clear(file, 0x914A, 0x1E4C); //code
  clear(file, 0xAF96, 0x0012); //string?
}

void draw() {
  for (int i=0; i<COLS*LINES; i++) {
    memory[GREEN+i]=file[i+offset];
  }

  //int i=0;
  //for (int y=0; y<12; y++) {
  //  for (int x=0; x<8; x++) {
  //    for (int row=0; row<4; row++) {
  //      for (int col=0; col<4; col++) {
  //        memory[RED + i] = 255;
  //        memory[GREEN + i] = 255;
  //        memory[BLUE + i] = 255;
  //        i++;
  //      }
  //    }
  //  }
  //}
  //0x0C30, 64*192



  VRAMtoImage(img);

  image(img, 0, 0, width, height);
}

void clear(byte b[], int offset, int count) {
  for (int i=0; i<count; i++) b[offset+i]=0;
}

void VRAMtoImage(PImage img) {
  img.loadPixels();
  for (int y=0, bit=0, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (memory[RED+i] & bit)>0 ? 255 : 0;
      int g = (memory[GREEN+i] & bit)>0 ? 255 : 0;
      int b = (memory[BLUE+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  offset = int(constrain(offset+e*4*72, 0, file.length-COLS*LINES));
  println(offset, "0x"+hex(offset, 4));
}



void setImageFromMemory(PImage img) {
  img.loadPixels();
  for (int y=0, bit=128, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      int r = (mem[R+i] & bit)>0 ? 255 : 0;
      int g = (mem[G+i] & bit)>0 ? 255 : 0;
      int b = (mem[B+i] & bit)>0 ? 255 : 0;
      img.pixels[j] = color(r, g, b);
    }
  }
  img.updatePixels();
}

void setMemoryFromImage(PImage img) { //expects 3-bit full R,G,B,W,C,M,Y,K
  img.loadPixels();
  for (int y=0, bit=0, j=0, w=img.width, h=img.height; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8), j++) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4;
      if ((int(red(img.pixels[j]))&255)>0) mem[R+i] |= bit;
      //else mem[R+i] &= ~bit;
      if ((int(green(img.pixels[j]))&255)>0) mem[G+i] |= bit;
      //else mem[G+i] &= ~bit;
      if ((int(blue(img.pixels[j]))&255)>0) mem[B+i] |= bit;
      //else mem[B+i] &= ~bit;
    }
  }
}

void clearChannels(boolean r, boolean g, boolean b) {
  for (int i=0; i<COLS*4*50; i++) {
    if (r) mem[R+i] = 0;
    if (g) mem[G+i] = 0;
    if (b) mem[B+i] = 0;
  }
}

void clearAll() {
  clearChannels(true,true,true);
}

void clearR() {
  clearChannels(true,false,false);
}

void clearG() {
  clearChannels(false,true,false);
}

void clearB() {
  clearChannels(false,false,true);
}

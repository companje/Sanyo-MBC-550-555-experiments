void setup() {
  size(2048, 4);
  for (int x=0; x<width; x++) {
    stroke(lerpColor(color(0), color(0, 255, 0), float(x)/width));
    line(x, 0, x, height);
  }
  save("tmp.png");

  PImage img = loadImage("tmp.png");
  img = applyDithering(img, 1);

  int intensity[][] = new int[256][4];

  for (int i=0; i<256; i++) {
    for (int j=0; j<4; j++) {
      int v = 0;
      for (int q=0; q<8; q++) {
        v |= brightness(img.get(i*8+q, j))>0 ? 1 : 0; 
        if (q<7) v <<= 1;
      }
      intensity[i][j] = v;
    }
  }
  //println(intensity[128]);

  print2DArray(intensity);


  img.save("tmp2.png");
}


PImage applyDithering(PImage img, int factor) {//factor is num colors per channel (1=black/white)
  img.loadPixels();
  for (int y = 0; y<img.height; y++) {
    for (int x = 0; x<img.width; x++) {
      color pix = img.pixels[y*img.width+x];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);

      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);

      img.pixels[y*img.width+x] = color(newR, newG, newB);
      float errR = oldR-newR;
      float errG = oldG-newG;
      float errB = oldB-newB;

      //Burkes dithering
      if (x<img.width-1) ditherPass(img, x+1, y, errR, errG, errB, 8/32.);
      if (x<img.width-2) ditherPass(img, x+2, y, errR, errG, errB, 4/32.);
      if (y<img.height-1) {
        ditherPass(img, x-2, y+1, errR, errG, errB, 2/32.);
        if (x>0) ditherPass(img, x-1, y+1, errR, errG, errB, 4/32.);
        ditherPass(img, x-0, y+1, errR, errG, errB, 8/32.);
        if (x<img.width-1) ditherPass(img, x+1, y+1, errR, errG, errB, 4/32.);
        if (x<img.width-2) ditherPass(img, x+2, y+1, errR, errG, errB, 2/32.);
      }
    }
  }
  img.updatePixels();
  return img;
}

void ditherPass(PImage img, int x, int y, float errR, float errG, float errB, float w) {
  color c = img.pixels[y*img.width+x];
  float r = red(c) + errR * w;
  float g = green(c) + errG * w;
  float b = blue(c) + errB * w;
  img.pixels[y*img.width+x] = color(r, g, b);
}

void print2DArray(int[][] array) {
  print("{ ");
  for (int i = 0; i < array.length; i++) {
    print("{");
    for (int j = 0; j < array[i].length; j++) {
      print(array[i][j]);
      if (j < array[i].length - 1) print(", ");
    }
    print("}");
    if (i < array.length - 1) print(", ");
  }
  println(" }");
}

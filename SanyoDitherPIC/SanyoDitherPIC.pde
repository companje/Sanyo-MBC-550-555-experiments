//ArrayList<String> filenames = new ArrayList();
//String extension = ".jpg";

void setup() {
  //size(640, 400);
  //frameRate(30);
  //background(0);
  //noStroke();
  //File[] files = new File(dataPath("input/")).listFiles(); //.replaceAll("data/",""))).listFiles();
  //for (int i=0; i<files.length; i++) {
  //  if (files[i].getName().endsWith(extension)) {
  //    filenames.add(files[i].getName());
  //  }
  //}

  String inputFilename = "data/input/beker.png";
  String outputFilename = "/Users/rick/Sanyo/Sanyo-MBC-550-555-experiments/bootpic/beker.pic";
  PImage img = loadImage(inputFilename);
  savePIC(img, outputFilename, false);
  println("done");
  
  size(320,320);
  noSmooth();
  img = loadPIC(outputFilename, 32, 16);
  image(img,0,0,width,height);
 
}

PImage loadPIC(String filename, int w, int h) { //PIC without header!
  byte bytes[] = loadBytes(filename);
  PImage img = createImage(w,h,RGB);
  for (int i=0, x=0, y=0, n=w*h/8; i<n; i++) {
    for (int j=128; j>0; j/=2, x=(x+1)%w, y=i/(w/8)) {
      int rr=(bytes[i+2*n]&j)/j<<8;
      int gg=(bytes[i+1*n]&j)/j<<8;
      int bb=(bytes[i+0*n]&j)/j<<8;
      img.set(x,y,color(rr, gg, bb));
    }
  }
  return img;
}

void savePIC(PImage img, String filename, boolean header) {
  int headerLength = header ? 4 : 0;
  byte bytes[] = new byte[img.width*img.height*3/8+headerLength];
  if (header) {
    bytes[0] = byte(img.width & 255);
    bytes[1] = byte(img.width >> 8);
    bytes[2] = byte(img.height & 255);
    bytes[3] = byte(img.height >> 8);
  }

  for (int i=0, x=0, y=0, n=img.width*img.height/8; i<n; i++) {
    for (int j=128; j>0; j/=2, x=(x+1)%img.width, y=i/(img.width/8)) {
      color c = img.get(x, y);
      bytes[i+headerLength+2*n] |= byte(j * red(c)/255);
      bytes[i+headerLength+1*n] |= byte(j * green(c)/255);
      bytes[i+headerLength+0*n] |= byte(j * blue(c)/255);
    }
  }

  saveBytes(filename, bytes);
}


void draw() {
  //String filename = filenames.get(int(float(mouseX)/width*filenames.size()));
  //PImage img = loadImage("input/"+filename);
  ////img.filter(GRAY);
  //img.resize(width, 200);
  //img = applyDithering(img, 1);
  //savePIC(img, "data/output/"+filename.replace(extension, ".pic"));
  //PImage img2 = createImage(width, height, RGB);
  //scaleInto(img, img2);
  //image(img2, 0, 0);
}

void drawPIC(String filename) {
  byte bytes[] = loadBytes(filename);
  int w = (bytes[1]<<8) + (bytes[0] & 0xff);
  int h = (bytes[3]<<8) + (bytes[2] & 0xff);

  noStroke();
  for (int i=0, x=0, y=0, n=w*h/8; i<n; i++) {
    for (int j=128; j>0; j/=2, x=(x+1)%w, y=i/(w/8)) {
      int rr=(bytes[i+2*n+4]&j)/j<<8;
      int gg=(bytes[i+1*n+4]&j)/j<<8;
      int bb=(bytes[i+0*n+4]&j)/j<<8;
      fill(rr, gg, bb);
      rect(x, y*2, 1, 1.75); //double height, with slight vertical raster line in between the lines
    }
  }
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

PImage scaleInto(PImage img, PImage img2) { //scale img into img2
  img2.loadPixels();
  img.loadPixels();
  for (int y=0; y<img2.height; y++) {
    for (int x=0; x<img2.width; x++) {
      int xx = int(float(x)/img2.width*img.width);
      int yy = int(float(y)/img2.height*img.height);
      img2.pixels[y*img2.width+x] = img.pixels[yy*img.width+xx];
    }
  }
  img2.updatePixels();
  return img2;
}

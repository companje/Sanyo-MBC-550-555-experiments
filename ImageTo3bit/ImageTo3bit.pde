PImage img;
color[] palette = {
  color(255, 0, 0), // Rood
  color(0, 255, 0), // Groen
  color(0, 0, 255), // Blauw
  color(255, 255, 255), // Wit
  color(0, 255, 255), // Cyaan
  color(255, 0, 255), // Magenta
  color(255, 255, 0), // Geel
  color(0, 0, 0)      // Zwart
};

void setup() {
  img = loadImage("huisjes.jpg"); //IMG_0547.jpg"); //eleven3.jpg");
  size(640, 200);
  img.resize(width, height);
  //posterizeImage(8);
  ditherImage();
  //removeIsolatedPixels(7);
  //blendEdgePixels();
  image(img, 0, 0);
  savePIC(img, "huisjes.pic");
  noLoop();
}

void draw() {
}

void ditherImage() {
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color oldColor = img.pixels[y * img.width + x];
      color newColor = findClosestPaletteColor(oldColor);
      img.pixels[y * img.width + x] = newColor;

      int errorR = (int)(red(oldColor) - red(newColor));
      int errorG = (int)(green(oldColor) - green(newColor));
      int errorB = (int)(blue(oldColor) - blue(newColor));

      distributeError(x, y, errorR, errorG, errorB);
    }
  }
  img.updatePixels();
}

void posterizeImage(int levels) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    float r = floor(red(img.pixels[i]) / 256.0 * levels) * (255 / (levels - 1));
    float g = floor(green(img.pixels[i]) / 256.0 * levels) * (255 / (levels - 1));
    float b = floor(blue(img.pixels[i]) / 256.0 * levels) * (255 / (levels - 1));
    img.pixels[i] = color(r, g, b);
  }
  img.updatePixels();
}

color findClosestPaletteColor(color c) {
  float minDist = 999999;
  color closestColor = color(0);
  for (color paletteColor : palette) {
    float d = dist(red(c), green(c), blue(c), red(paletteColor), green(paletteColor), blue(paletteColor));
    if (d < minDist) {
      minDist = d;
      closestColor = paletteColor;
    }
  }
  return closestColor;
}

void distributeError(int x, int y, int errorR, int errorG, int errorB) {
  applyError(x + 1, y, errorR, errorG, errorB, 7.0 / 16.0);
  applyError(x - 1, y + 1, errorR, errorG, errorB, 3.0 / 16.0);
  applyError(x, y + 1, errorR, errorG, errorB, 5.0 / 16.0);
  applyError(x + 1, y + 1, errorR, errorG, errorB, 1.0 / 16.0);
}

void applyError(int x, int y, int errorR, int errorG, int errorB, float factor) {
  if (x >= 0 && x < img.width && y >= 0 && y < img.height) {
    color c = img.pixels[y * img.width + x];
    int newR = constrain((int)(red(c) + errorR * factor), 0, 255);
    int newG = constrain((int)(green(c) + errorG * factor), 0, 255);
    int newB = constrain((int)(blue(c) + errorB * factor), 0, 255);
    img.pixels[y * img.width + x] = color(newR, newG, newB);
  }
}

void removeIsolatedPixels(int minSameColorNeighbors) {
  img.loadPixels();
  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      color center = img.pixels[y * img.width + x];
      color neighborColor = img.pixels[(y - 1) * img.width + (x - 1)];

      int sameColorCount = 0;
      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          if (dx != 0 || dy != 0) {
            color neighbor = img.pixels[(y + dy) * img.width + (x + dx)];
            if (neighbor == neighborColor) {
              sameColorCount++;
            }
          }
        }
      }

      if (sameColorCount >= minSameColorNeighbors && center != neighborColor) {
        img.pixels[y * img.width + x] = neighborColor;
      }
    }
  }
  img.updatePixels();
}

void blendEdgePixels() {
  img.loadPixels();
  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      color center = img.pixels[y * img.width + x];

      HashMap<Integer, Integer> colorCounts = new HashMap<Integer, Integer>();
      for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
          int neighborColor = img.pixels[(y + dy) * img.width + (x + dx)];
          colorCounts.put(neighborColor, colorCounts.getOrDefault(neighborColor, 0) + 1);
        }
      }

      if (colorCounts.size() == 2) {
        color dominantColor = getMostFrequentColor(colorCounts);
        img.pixels[y * img.width + x] = dominantColor;
      }
    }
  }
  img.updatePixels();
}

color getMostFrequentColor(HashMap<Integer, Integer> colorCounts) {
  int maxCount = 0;
  int dominantColor = color(0);
  for (int c : colorCounts.keySet()) {
    int count = colorCounts.get(c);
    if (count > maxCount) {
      maxCount = count;
      dominantColor = c;
    }
  }
  return dominantColor;
}

void savePIC(PImage img, String filename) {
  byte bytes[] = new byte[img.width*img.height*3/8+4];
  bytes[0] = byte(img.width & 255);
  bytes[1] = byte(img.width >> 8);
  bytes[2] = byte(img.height & 255);
  bytes[3] = byte(img.height >> 8);

  for (int i=0, x=0, y=0, n=img.width*img.height/8; i<n; i++) {
    for (int j=128; j>0; j/=2, x=(x+1)%img.width, y=i/(img.width/8)) {
      color c = img.get(x, y);
      bytes[i+4+2*n] |= byte(j * red(c)/255);
      bytes[i+4+1*n] |= byte(j * green(c)/255);
      bytes[i+4+0*n] |= byte(j * blue(c)/255);
    }
  }

  saveBytes(filename, bytes);
}

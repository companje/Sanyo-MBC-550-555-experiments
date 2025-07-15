int w = 320;
int h = 200;
int[][] stability;
color[][] lastFrame;

void setup() {
  size(640, 200);
  stability = new int[w][h];
  lastFrame = new color[w][h];
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = color(0);
  }
  updatePixels();
}

void draw() {
  loadPixels();
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int idxL = y * width + x;
      int idxR = y * width + (x + w);

      color newColor = calculatePixel(x, y);
      color prevColor = lastFrame[x][y];

      if (newColor == prevColor) {
        stability[x][y]++;
      } else {
        stability[x][y] = 0;
        lastFrame[x][y] = newColor;
      }

      int skipFactor = (int)pow(2, min(4, stability[x][y] / 5));
      if (frameCount % skipFactor == 0) {
        pixels[idxL] = newColor;
      }

      float normStability = constrain(stability[x][y] / 30.0, 0, 1);
      int shade = int(normStability * 255);
      pixels[idxR] = color(shade);
    }
  }
  updatePixels();
}

color calculatePixel(int x, int y) {
  float v = sin((x + frameCount) * 0.05) * 127 + 128;
  if (v<50) v=0;
  else if (v>255-50) v=0;
  else v=255;
  return color(v, v, v);
}

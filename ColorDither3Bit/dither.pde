void ditherImage(PImage img) {
  img.loadPixels();

  int cellsX = 16;
  int cellsY = 1;

  int cellWidth = (int)ceil((float)img.width / cellsX);
  int cellHeight = (int)ceil((float)img.height / cellsY);

  for (int cellY = 0; cellY < img.height; cellY += cellHeight) {
    for (int cellX = 0; cellX < img.width; cellX += cellWidth) {

      for (int y = cellY; y < cellY + cellHeight && y < img.height; y++) {
        for (int x = cellX; x < cellX + cellWidth && x < img.width; x++) {
          int index = y * img.width + x;
          color oldColor = img.pixels[index];
          color newColor = findClosestPaletteColor(oldColor);
          img.pixels[index] = newColor;

          int errorR = (int)(red(oldColor) - red(newColor));
          int errorG = (int)(green(oldColor) - green(newColor));
          int errorB = (int)(blue(oldColor) - blue(newColor));

          distributeErrorInCell(x, y, errorR, errorG, errorB, cellX, cellY, cellWidth, cellHeight);
        }
      }

    }
  }

  img.updatePixels();
}

void distributeErrorInCell(int x, int y, int errorR, int errorG, int errorB, int cellX, int cellY, int cellWidth, int cellHeight) {
  int[][] offsets = {
    {1, 0, 7},
    {-1, 1, 3},
    {0, 1, 5},
    {1, 1, 1}
  };

  for (int[] o : offsets) {
    int dx = o[0];
    int dy = o[1];
    int factor = o[2];

    int nx = x + dx;
    int ny = y + dy;

    if (nx >= cellX && nx < cellX + cellWidth && ny >= cellY && ny < cellY + cellHeight && nx < img.width && ny < img.height) {
      int nIndex = ny * img.width + nx;
      color c = img.pixels[nIndex];
      int r = constrain((int)(red(c) + errorR * factor / 16.0), 0, 255);
      int g = constrain((int)(green(c) + errorG * factor / 16.0), 0, 255);
      int b = constrain((int)(blue(c) + errorB * factor / 16.0), 0, 255);
      img.pixels[nIndex] = color(r, g, b);
    }
  }
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

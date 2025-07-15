int[][]  plas_lut;
int[]    palette  = new int[255];
PImage pg;

void setup()
{
  pg = createImage(16, 16, RGB);
  //size(640, 400);
  fullScreen();
  plas_lut = new int[pg.width][pg.height];

  buildPalette();
  buildMap();
}

void buildPalette ()
{
  colorMode(HSB);
  for (int i=0; i<palette.length; i++)
  {
    //int h = int(128.0 + 128 * asin(PI * (float)i / 32.0));
    int s = int(128.0 + 128 * cos(PI * (float)i / 64.0));
    int b = int(128.0 + 128 * sin(PI * (float)i / 128.0));
    palette[i] = color(140, s, b+25);
  }
}

void buildMap () {
  for (int y=0; y<pg.height; y++) {
    for (int x=0; x<pg.width; x++) {

      float v = 256;

      //float b = sin(x / v);
      //b *= pow(1/cos(y / v), -1);
      //b *= sin(x/v);
      //b *= sin(float(x+y)/v);
      //b *= cos(sqrt(x*x + y*y)/v);

      //int k = int(b*128+128);

      int k = 128+int(0
        + 128f + 256f * pow(1/cos(y / v), -1)
        + 128f + 128f * sin(x / v)
        + 128f + 128f * sin((x+y)/(v/2))
        + 128f + 128f * cos(sqrt(x*x + y*y) / v)
        + 128f + 1 * sin((float)x/pg.width)
        );

      plas_lut[x][y] = k;
    }
  }
}

void draw()
{
  pg.loadPixels();
  for (int x=0, i=0; x<pg.width; x++) {
    for (int y=0; y<pg.height; y++, i++) {

      float xx=float(x)/pg.width*16 + mouseX*.1;
      float yy=float(y)/pg.height*16  + mouseY*.1;
      float t = frameCount*.1;
      float tixy = cos(t + i + xx * yy);

      pg.pixels[y*pg.width + x] = palette[int(tixy*128+128)%255];
    }
  }
  //(plas_lut[x][y] + frameCount*2) % 255];
  pg.updatePixels();

  image(pg, 0, 0, width, height);
}


//void setup()
//{
//  size(1112,834);
//}

//void buildPalette ()
//{
//  colorMode(HSB);
//  for(int i=0;i<palette.length;i++)
//  {
//    //int h = int(128.0 + 128 * asin(PI * (float)i / 32.0));
//    int s = int(128.0 + 128 * cos(PI * (float)i / 64.0));
//    int b = int(128.0 + 128 * sin(PI * (float)i / 128.0));
//    palette[i] = color(140,s,b+25);
//  }
//}

void buildMap ()
{
  for(int x=0;x<COLS;x++) for(int y=0;y<ROWS;y++)
  {
    plas_lut[x][y] = 128+int(
      128f + (128f * sin(x / 56f))
           + 128f + (256f * pow(1/cos(y / 50f),-1))
    + 128f * sin((float)x/COLS)
    + 128f + 128*sin((x+y)/128f)
    + 128f + (128f * cos(sqrt(x*x + y*y) / 56f)));
  }
}

//void draw()
//{
//  loadPixels();
//  for(int x=0;x<COLS;x++) for(int y=0;y<ROWS;y++)
//    pixels[y*COLS + x] = palette[(plas_lut[x][y] + frameCount*2) % 255];
//  updatePixels();
//}

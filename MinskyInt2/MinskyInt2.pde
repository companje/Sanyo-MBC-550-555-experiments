int mem[] = new int[1024*1024*2];

void setup() {
  size(512, 256);
  background(0);
  stroke(255);
}

void draw() {
  background(0);
  line(256+64, 0, 256+64, height);
  line(0+64, 0, 0+64, height);
  line(0, height/2, width, height/2);

  int d = 202;
  int x = 1100;
  int y = 0;

  int cx=512;
  int bp=0;
  do {
    int a = d*y;
    a>>=14;

    int b = d*x;
    b>>=14;

    x+=a;
    y-=b;

    int xx = ((bp>>1) + 3) & 255;
    int yy = (y>>3) + 122;

    mem[xx] = yy;

    y++;
    bp++;
  } while (--cx>0);

  for (int i=0; i<256; i++) {
    point(i, mem[i]);
  }
}

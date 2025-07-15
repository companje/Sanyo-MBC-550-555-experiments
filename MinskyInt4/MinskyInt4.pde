int mem[] = new int[1024*1024*2];
int n=256; //4*512;

void setup() {
  size(256, 256);
  background(0);
  stroke(255);
}

void draw() {
  background(0);
  line(256+64, 0, 256+64, height);
  line(0+64, 0, 0+64, height);
  line(0, height/2, width, height/2);

  //int d = 202;
  int d = 128;
  int x = 1038;
  println(x);
  int y = 0;

  int cx=n;
  int bp=0;
  do {
    int a = d*y;
    a>>=14;

    int b = d*x;
    b>>=14;

    x+=a;
    y-=b;

    println(mouseX, mouseY);

    //int xx = ((bp>>1) + 3) - mouseX ; //& 255;

    //xx *= (mouseY/100.);

    //if (xx<0) xx=0;

    int xx=bp;

    int yy = (y>>3) + mouseX;
    
    yy *= (mouseY/10.);

    mem[xx] = yy;

    //y++;
    bp++;
  } while (--cx>0);

  for (int i=0; i<n; i++) {
    point(i, mem[i]);
  }
}

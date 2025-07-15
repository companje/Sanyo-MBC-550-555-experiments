PImage img, img2;
PGraphics pg;
int di, x, y, xx=1, channel;
int COLS=64;
int NUM=COLS*200;
int[] stability = new int[NUM];
int mem[] = new int[1024*1024*2];
int R=0xf0000, G=0x0C000, B=0xf4000;
int channels[] = {R, G, B};

void setup() {
  size(1280, 800, P2D);
  noSmooth();
  frameRate(60);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height);
}

void draw() {


  //WERKT NIET GOED (chatgpt)

  for (int i = 0; i < 10000; i++) {
    di = (di + xx) % NUM;
    y = ((di >> 8) << 2) | di & 3;
    x = (di >> 2) & COLS;

    //int skipFactor = (int)pow(2, min(4, stability[di] / 5));
    //if (frameCount % skipFactor != 0) {
    //  continue; // sla berekeningen voor deze pixel over
    //}

    //boolean changed = false;

    for (int cc = 0; cc < 3; cc++) {
      channel = cc;
      effect();
      int addr = channels[cc] + di;
      int newVal = al.get();
      //  int prevVal = mem[addr];

      //  if (newVal != prevVal) {
      //    changed = true;
      //  }
      mem[addr] = newVal;
    }

    //    if (changed) {
    //      stability[di]++;
    //    } else {
    //      stability[di] = 0;
    //    }
  }

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}


void effect() {
  al.set(channel);
  al.add(channel);
  al.add(channel);
  al.add(frameCount);
  sine256();
  int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  if (y < barY) al.set(0);
  else if (y > barY + 10) al.set(0);
  else al.set(255);
}

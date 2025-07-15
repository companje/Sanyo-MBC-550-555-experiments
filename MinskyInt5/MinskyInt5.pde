int mem[] = new int[1024*1024*2];
import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int d = 404;
int ax, bx, cx, dx, di;
color colors[] = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0) };
int bp=1100; //x
int si=1;    //y


void setup() {
  size(512, 256);
  background(0);
  generate_sine();
}

void draw() {
  stroke(255, 255, 0);
  for (int i=0; i<512; i++) {
    point(i, mem[i]);
    println(i, mem[i]);
  }
  noLoop();
}

void generate_sine() {
  for (int cx=63; cx>=0; cx--) {
    stack.push(cx);

    cx = 404;
    bx = 16384;

    ax = si;
    dx = 0; //clear dx for mul
    ax *= cx; //from 16 to 32 bits
    ax /= bx; //from 32 bits to 16 bits

    stack.push(ax);

    ax = bp;
    dx = 0; //clear dx for mul
    ax *= cx; //from 16 to 32 bits
    ax /= bx; //from 32 bits to 16 bits

    si-=ax;

    ax=stack.pop();
    bp+=ax;

    int cl = 28;
    ax = si;
    ax *= cl;   //from 8 to 16 bits
    cl = 8;
    ax >>= cl;

    dx = 128;

    ax += dx;

    //mem[di] = ax;

    //stack.push(di);
    //di-= dx;
    //di = -di;
    //mem[di] = ax;
    //di = stack.pop();

    //ax *= -1;
    //ax += 255;

    //stack.push(di);
    //di+=dx;
    //mem[di] = ax;
    //di = stack.pop();

    //stack.push(di);
    //di = -di;
    //di += 255;
    //mem[di] = ax; //stosb met di (let op, bx ipv ax
    //di = stack.pop();

    int offset = 0;

    stack.push(cx);
    for (cx=5; cx>=0; cx--) {
      stack.push(ax);
      stack.push(di);
      offset=cx*64;
      if (cx%2==1) {
        di=-di;
        offset+=63;
      }
      if ((cx&2)!=0) {
        ax=255-ax;
      }
      di+=offset;
      mem[di]=ax;

      di=stack.pop();
      ax=stack.pop();
    }
    cx=stack.pop();
    cx=stack.pop();
    di++;
  }
}

int mem[] = new int[1024*1024*2];
import java.util.ArrayDeque;
ArrayDeque<Integer> stack = new ArrayDeque<Integer>();
int d = 404;
int ax, bx, cx, dx, di;
int cl; //vorsicht
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
  for (int i=0; i<6*64; i++) { //6 ipv 4 ivm offset for cos vs sin
    point(i, mem[i]);
    println(i, mem[i]);
  }
  noLoop();
}

void generate_sine() {
  for (int cx=63; cx>=0; cx--) {
    stack.push(cx);
    cx = 404;
    bx = 2<<13;

    ax = si;  //ax = y
    dx = 0;   //clear dx for mul
    ax *= cx; //from 16 to 32 bits
    ax /= bx; //from 32 bits to 16 bits

    stack.push(ax);
    ax = bp;  //ax = x
    dx = 0;   //clear dx for mul
    ax *= cx; //from 16 to 32 bits
    ax /= bx; //from 32 bits to 16 bits
    si -= ax; //y-=ax
    ax = stack.pop();
    bp += ax;

    cx = 28;  //dit is ok omdat aan het begin van de loop cx is gepushed. 
    ax = si;      //ax = y
    ax *= cx;     //from 16 to 32 bits... was 8 to 16 ?? checkme
    cl = 8;
    ax >>= cl;
    ax += 128; //al+=128 ook goed?
    
    ax = ax&255;

//mem[di]=ax;

    for (cx=5; cx>=0; cx--) {
      stack.push(ax);
      stack.push(di);
      stack.push(cx); //nodig omdat cl wordt aangepast naar 6
      bx = cx; 
      cl = 6;
      bx <<= cl;        //bx=cx*64
      cx = stack.pop(); //herstel cx naar 0..5
      if ((cx&1)!=0) {  //odd/even
        di = -di;       //neg di
        bx += 63;
      }
      if ((cx&2)!=0) { // >1
        ax=255-ax; //in assembly kan ik NOT AL doen
      }
      di += bx;
      mem[di]=ax;
      di=stack.pop();
      ax=stack.pop();
    }
    
    cx=stack.pop();
    di++;
  }
}

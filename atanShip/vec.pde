void copy(int p, int q) {
  mem[p+0] = mem[q+0];
  mem[p+1] = mem[q+1];
}

void add(int p, int q) {
  mem[p+0] += mem[q+0];
  mem[p+1] += mem[q+1];
}

void sub(int p, int q) {
  mem[p+0] -= mem[q+0];
  mem[p+1] -= mem[q+1];
}

void mult(int p, int x) {
  mem[p+0] *= x;
  mem[p+1] *= x;
}

void div(int p, int x) {
  mem[p+0] /= x;
  mem[p+1] /= x;
}

void scale(int p, int x) {
  mem[p+0] = (mem[p+0]*x) / 100;
  mem[p+1] = (mem[p+1]*x) / 100;
}

//void limit(int p, int x) {
//  //while (magSq(p) > x*x) {
//  //  scale(p,95);
//  //  //mult(p, 95);
//  //  //div(p, 100);
//  //}
//}

//5*2 = 10

//25 * 25

//5 * 25 * 5

void limit(int p, int x) {
    int magSq = magSq(p);
    println(magSq);
    int xSq = x * x;
    println(xSq);
    if (magSq > xSq) {
        // Bereken de schaalfactor als een breuk
        int num = xSq;
        int denom = magSq;

        // Schaal de vector zonder wortel
        mem[p] = (mem[p] * num) / denom;
        mem[p + 1] = (mem[p + 1] * num) / denom;
    }
}

int magSq(int p) {
  return mem[p]*mem[p]+mem[p+1]*mem[p+1];
}

void cos() { //ax in deg
  stack.push(cx);
  cx = ax;
  ax = 90;
  ax -= cx;
  ax *= 100;
  ax += 45;
  ax /= 9;
  cx = stack.pop();
}

void sin() { //ax in deg
  ax *= 100;
  ax += 45;
  ax /= 9;
}

void fromAngle() { //ax=angle, bx=mag, returns ax=x, bx=y  
  cx=360;
  ax+=cx;

  ax%=cx; //div cx, xchg ax,dx
  dx=0;
  cx=90;
  dx=ax%90; //div cx
  ax/=90; //quadrant 0,1,2,3

  stack.push(ax); //quadrant
  ax = dx;
  
  stack.push(dx); //save angle within quadrant
  sin();
  ax*=bx;
  cx = bx;  //cx = mag
  bx = ax;  //bx = sin()

  ax = stack.pop(); //restore angle within quadrant
  cos();
  ax*=cx;
  dx = ax;  //dx = cos()

  cx = stack.pop(); //quadrant
  
  if (cx==0) {
    ax = dx;
  } else if (cx==1) {
    ax = -bx;
    bx = dx;
  } else if (cx==2) {
    ax = -dx;
    bx = -bx;
  } else {
    ax = bx;
    bx = -dx;
  }

}


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

void limit(int p, int x) {
  while (magSq(p) > x*x) { // alternatief zonder loop werkt nog niet
    scale(p, 95);
  }
}

int magSq(int p) {
  return mem[p]*mem[p]+mem[p+1]*mem[p+1];
}

//geen magnitude
void v_from_angle() { //input ax=angle, output ax=x, bx=y
  stack.push(ax);
  sin_15steps();
  bx = ax;    //bx=y result
  ax = stack.pop();
  cos_15steps(); //ax=x result
}

void v_mult() { //ax=scaler, bx=pointer
  mem[bx+0] *= ax;
  mem[bx+1] *= ax;
}

void v_set() { //ax=x, bx=y, bp=pointer
 mem[bp+0] = ax;
 mem[bp+1] = bx;
}

  
//overwegen dit met een pointer (bx) te laten werken zoals de rest
//en dan de magnitude in cx
//void fromAngle() { //ax=angle, bx=mag, returns ax=x, bx=y
//  cx=360;
//  ax+=cx;

//  ax%=cx; //div cx, xchg ax,dx
//  dx=0;
//  cx=90;
//  dx=ax%90; //div cx
//  ax/=90; //quadrant 0,1,2,3

//  stack.push(ax); //quadrant
//  ax = dx;

//  stack.push(dx); //save angle within quadrant
//  sin_15steps();
//  ax*=bx;
//  cx = bx;  //cx = mag
//  bx = ax;  //bx = sin()

//  ax = stack.pop(); //restore angle within quadrant
//  cos_15steps();
//  ax*=cx;
//  dx = ax;  //dx = cos()

//  cx = stack.pop(); //quadrant

//  if (cx==0) {
//    ax = dx;
//  } else if (cx==1) {
//    ax = -bx;
//    bx = dx;
//  } else if (cx==2) {
//    ax = -dx;
//    bx = -bx;
//  } else {
//    ax = bx;
//    bx = -dx;
//  }
//}

//rnd:
//  push bx
//  push cx
//  push dx
//  mov cx, 16
//.lp
//  mov ax,[.seed]
//  xor dx, dx           ; DX wordt gebruikt om het nieuwe bit te berekenen
//  mov bx, ax           ; Kopieer de huidige waarde van AX naar BX
//  ; shr bx, 0            ; Feedback van het laagste bit (bit 0)
//  xor dl, bl           ; Voeg de laagste bit aan DX toe

//  shr bx, 1            ; Feedback bit 1
//  xor dl, bl

//  push cx
//  mov cl,4
//  shr bx, cl           ; Feedback bit 4
//  xor dl, bl

//  mov cl,15
//  shr bx, cl           ; Feedback bit 15
//  xor dl, bl

//  shl ax, 1            ; Verschuif de registerwaarde in AX
//  or ax, dx            ; Voeg de berekende bit toe

//  pop cx
//  loop .lp        ; Herhaal totdat CX 0 is

//  mov [.seed],ax
//  pop dx
//  pop cx
//  pop bx
//  ret
//  .seed dw 0B400h

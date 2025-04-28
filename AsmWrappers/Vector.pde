class Vec {
  String name;
  Mem16 x = new Mem16();
  Mem16 y = new Mem16();

  Vec(String name) {
    this.name = name;
  }

  String toString() {
    return name + ": " + x + " " + y;
  }
}

void addForceFromAngle() { // input ax = current angle + rel angle
  println("addForceFromAngle");
  mov(cx, 5);   //  magnitude
  mov(ax, 0);   //  TMP

  mov(bx, ship.force);     //addr
  v_from_angle_mag();

  mov(bx, ship.forces);    //addr
  mov(bp, ship.force);     //addr
  v_add();  // [bx]+=[bp]
}

void v_from_angle_mag() { // input: ax=angle, cx=mag, output: bx=vector
  push(dx);
  xy_from_angle(); // ax = angle [any] -> ax,dx = x,y [-100..100]
  mov(mem16(cs, bx, +0), ax);
  mov(mem16(cs, bx, +2), dx);
  pop(dx);
  v_mult(); // bx=vector, cx=scaler
}

void v_mult() { //bx=vector, cx=scaler, output: bx=vector
  mov(ax, mem16(cs, bx)); //x
  //cwd();
  //imul(cx);
  mov(mem16(cs, bx), ax);

  mov(ax, mem16(cs, bx, +2));  //y
  //cwd();
  //imul(cx);
  mov(mem16(cs, bx, +2), ax);
}

void v_set() { //[bx] = ax:dx
  mov(mem16(cs, bx, +0), ax);
  mov(mem16(cs, bx, +2), dx);
}

void v_add() { // [bx]+=[bp]
  add(mem16(cs, bx, +0), mem16(cs, bp, +0));
  add(mem16(cs, bx, +2), mem16(cs, bp, +2));
}

void v_sub() { // [bx]-=[bp]
  sub(mem16(cs, bx, +0), mem16(cs, bp, +0));
  sub(mem16(cs, bx, +2), mem16(cs, bp, +2));
}

void v_copy() { // input bx=target,bp=source: copy vec bp into vec bx
  mov(ax, mem16(cs, bp, +2));
  mov(mem16(cs, bx, +2), ax);
  mov(ax, mem16(cs, bp, +2));
  mov(mem16(cs, bx, +2), ax);
}

boolean v_if_zero() {
  //v_if_zero: ; [bx]==0    ; dit is geen goede test. want x=5,y=-5 levert ook 0 op.
  mov(ax, mem16(cs, bx, +0));
  add(ax, mem16(cs, bx, +2));
  //or(ax, ax);
  return ax.get()==0;
}

void v_limit() { // [bx] input vector, ax=max_length. destroys dx, updates [bx]      ; erg inefficient. zou moeten kunnen zonder loop
  push(bx);
  push(bp);
  mul(ax);  // ax*=ax
  xchg(bp, ax); // bp now contains max*max
lp:
  while (true) {
    v_mag_sq(); //     ; ax = magSq([bx])
    if (jle(ax, bp)) break;
    mov(cx, 95);
    v_scale();  // bx=vector, cx=scaler (x100), updates bx
  }
done:
  pop(bp);
  pop(bx);
}

void v_mag_sq() {
  v_mag_sq_scaled();
}

void v_mag_sq_scaled() {
  //ax=magSq([bx])
  //scaled down with 10
  push(bx);
  push(dx);
  push(cx);

  mov(ax, mem(bx));
  //cwd
  mov(cx, 10); //let op cx ipv cl
  //idiv cx
  //cwd
  //imul ax   ; moet dit niet gewoon mul zijn ipv imul?
  //mov [.xx],ax   // use cx for tmp copy of x*x
  //mov ax,[bx+2]
  //cwd
  //mov cx,10   ; let op cx ipv cl
  //idiv cx
  //cwd
  //imul ax   ; moet dit niet gewoon mul zijn ipv imul?
  //mov [.yy],ax   ; use cx for tmp copy of x*x

  //; print " y*y="
  //; println_ax ; //y*y

  //mov ax,[.xx]
  //add ax,[.yy]
  //cwd

  //mov cx,10   ; let op cx ipv cl
  //mul cx

  pop(cx);
  pop(dx);
  pop(bx);

  //.xx: dw 0
  //.yy: dw 0
}

void v_scale() { // bx=vector,  cx=scaler (x100), updates bx
  push(ax);
  mov(ax, mem16(cs, bx)); // x
  //cwd
  //imul(cx);
  push(cx);
  mov(cx, 100);
  //idiv(cx);
  pop(cx);
  mov(mem16(cs, bx), ax);
  mov(ax, mem16(cs, bx, +2)); //y
  //cwd
  //imul(cx);
  push(cx);
  mov(cx, 100);
  //idiv(cx);
  pop(cx);
  mov(mem16(cs, bx, +2), ax);
  pop(ax);
}

void v_clear() { // [bx]=0
  mov(mem16(cs, bx, +0), 0);
  mov(mem16(cs, bx, +2), 0);
}

void v_heading() { // bx contains address of 4 bytes vector
  mov(ax, mem16(cs, bx, +0));
  mov(bx, mem16(cs, bx, +2));
  atan2();
}

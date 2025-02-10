
void v_mult() { //ax=scaler, bx=pointer
  push(ax);
  push(cx);
  mov(cx, ax);
  mov(ax, mem(bx));  //x
  mul(cx);
  mov(mem(bx), ax);
  mov(ax,mem(bx,+1)); //y
  mul(cx);
  mov(mem(bx,+1), ax);
  pop(cx);
  pop(ax);
}

void v_add() {  //[bx]+=[bp]
  mov(ax,mem(bx));
  add(ax,mem(bp));   // bx.x += bp.x
  mov(mem(bx), ax);
  mov(ax,mem(bx,+1));
  add(ax,mem(bp,+1)); // bx.y += bp.y
  mov(mem(bx,+1), ax);
}

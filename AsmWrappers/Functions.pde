boolean jle(Reg a, Reg b) {
  return a.jle(b);  
}

void xchg(Reg a, Reg b) {
  Reg tmp = b;
  b = a;
  a = tmp;
}

Mem16 mem16() {
  Mem16 m = new Mem16();
  return m;
}

Mem16 mem16(Reg16 seg, Reg16 o, int i) {
  return new Mem16(seg, o.get()+i);
}

void mov(Reg r, Vec v) {
  r.mov(v.x.addr); //r becomes the address (pointer) of first Mem16 of the vector (v.x)
}

void stosw() {
  mov(mem16(es, di), ax);
  inc(di);
  inc(di);
}

void movsw() {
  mov(mem16(es, di), mem16(ds, si));
  inc(di);
  inc(di);
  inc(si);
  inc(si);
}

void push(Reg r) {
  r.push();
}

void pop(Reg r) {
  r.pop();
}

void dec(Reg r) {
  r.dec(); 
}

void inc(Reg r) {
  r.inc();
}

void or(Reg r, Reg r2) {
  r.or(r2); 
}

void xor(Reg r, Reg r2) {
  r.xor(r2); 
}

void idiv(Reg r) {
  
  println("fixme idiv(r)"); 
}

void mul(Reg16 r) {
  ax.mul(r);
}

void mul(Reg8 r) {
  al.mul(r);
}

void idiv(Reg16 r) {
  ax.idiv(r);
}

void idiv(Reg8 r) {
  al.idiv(r);
}
void mov(Mem16 a, Mem16 b) {
  a.mov(b);
}

void mov(Mem16 a, Reg b) {
  a.mov(b);
}

void mov(Reg r, Reg r2) {
  r.mov(r2);
}

void mov(Reg r, int v) {
  r.mov(v);
}

void mov(Mem m, int v) {
  m.mov(v);
}

void add(Reg r, int v) {
  r.add(v);
}

void add(Mem m, int v) {
  m.add(v);
}

void add(Reg r, Mem m) {
  r.add(m);
}

void add(Mem m, Mem m2) {
  m.add(m2.get());
}

void mov(Reg r, Mem m) {
  r.mov(m);
}

void sub(Reg r, Reg r2) {
  r.sub(r2);
}

void sub(Mem m, Mem m2) {
  m.sub(m2);
}

void sub(Reg r, int v) {
  r.sub(v);
}

void shl(Reg r, int v) {
  r.shl(v);
}

void shr(Reg r, int v) {
  r.shr(v);
}

void shr(Reg r, Reg r2) {
  r.shr(r2);
}

void shl(Reg r, Reg r2) {
  r.shl(r2);
}

Mem8 mem(Reg8 r) {
  return new Mem8(r);
}

Mem8 mem(Reg8 r, int offset) {
  return new Mem8(r, offset);
}

Mem8 mem8(int v) {
  return new Mem8(v);
}

Mem16 mem(Reg16 r) {
  return new Mem16(r);
}

Mem16 mem(Reg16 r, int offset) {
  return new Mem16(r, offset);
}

Mem16 mem16(Reg16 r, Reg16 r2) {
  return new Mem16(r, r2);
}

//Mem mem(int v) {
//  Thread.dumpStack();
//  throw new Error("byte or word implicit");
//}

Mem16 mem16(int v) {
  return new Mem16(v);
}

boolean loop_cx() {
  dec(cx);
  return cx.get()>0;
}

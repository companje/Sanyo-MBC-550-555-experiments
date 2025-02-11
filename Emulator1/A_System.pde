boolean ZF,SF,CF,OF;

void mov(Reg r, int v) {
  r.set(v);
}

void mov(Reg r, Mem m) {
  r.set(m.get());
}

void mov(Mem m, Reg r) {
  m.set(r.get());
}

void mov(Mem m, int v) {
  m.set((char)v);
}

void mov(Reg a, Reg b) {
  a.set(b.get());
}

void xor(Reg a, Reg b) {
  a.xor(b);
}

void cmp(Reg r, int v) {
  r.cmp(v);
}

boolean jl() {
  return SF!=OF; //(SF xor OF)=1 
}

void push(Reg r) {
  sp.set(sp.get()-2);
  mov(mem(sp), r);
}

void pop(Reg r) {
  mov(r, mem(sp));
  sp.set(sp.get()+2);
}

void mul(Reg16 r) {
  //houdt nog geen rekening met een bestaande waarde in DX
  //geen onderscheid nog tussen mul en imul
  int v = ax.get() * r.get();
  ax.set(v);
  if (v>0xffff) {
    //println("MUL16 overflow");
    dx.set(v>>16);
  }
}

void mul(Reg8 r) {
  int v = al.get() * r.get();
  al.set(v);
  if (v>0xff) {
    //println("MUL8 overflow");
    ah.set(v>>8);
  }
}

void add(Reg r, Mem m) {
  add(r, m.get());
}

void add(Reg a, Reg b) {
  a.add(b.get());
}

void add(Reg r, int v) {
  r.set(r.get()+v);
}

void add(Mem m, int v) {
  m.set((char)(m.get() + v));
}

void sub(Reg r, Mem m) {
  sub(r, m.get());
}

void sub(Reg a, Reg b) {
  sub(a, b.get());
}

void sub(Reg r, int v) {
  r.set(r.get()-v);
}

void sub(Mem m, int v) {
  m.set((char)(m.get() - v));
}

void dec(Reg r) {
  r.dec();
}

void shr(Reg r1, Reg r2) {
  r1.shr(r2);
}

void shl(Reg r1, Reg r2) {
  r1.shl(r2);
}

void shr(Reg r, int v) {
  if (v!=1) throw new Error("SHR operand should be 1 or REG");
  r.shr();
}

void shl(Reg r, int v) {
  if (v!=1) throw new Error("SHL operand should be 1 or REG");
  r.shl();
}

void or(Reg r1, Reg r2) {
  r1.or(r2);
}

boolean loop(Reg r) {
  if (r!=cx) throw new Error("LOOP needs CX");
  cx.set(cx.get()-1);
  return (cx.get())>0;
}

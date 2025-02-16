
static class Mem {
  protected static int mem[] = new int[1024*1024];

  Reg reg;
  int addr = 0;
  int offset = 0;

  Mem(Reg r) {
    reg = r;
    addr = r.get();  //LET OP: het register bevat het adres.
  }

  Mem(Reg r, int offset) {
    reg = r;
    addr = r.get();
    this.offset = offset;
  }

  Mem(int v) {
    addr = v;
  }

  int getAddr() {
    return (addr+offset);
  }

  void set(int v) {
    throw new Error("Missing Override for Mem.set() in subclass");
  }

  int get() {
    throw new Error("Missing Override for Mem.get() in subclass");
  }
  
  void mov(int v) {
    set(v);
  }

  String toString() {
    return (reg!=null ? "["+reg.name+"]=":"") + "["+getAddr()+"]="+get();
  }

}

static class Mem8 extends Mem {
  Mem8(Reg8 r) {
    super(r);
  }
  Mem8(Reg r, int offset) {
    super(r, offset);
  }
  Mem8(int v) {
    super(v);
  }
  int get() {
    return mem[getAddr()];
  }
  void set(int b) {
    mem[getAddr()] = b & 255;
  }
}

static class Mem16 extends Mem {
  Mem16(Reg16 r) {
    super(r);
  }
  Mem16(Reg r, int offset) {
    super(r, offset);
  }
  Mem16(int v) {
    super(v);
  }
  int get() { //16 bit word WAARDE
    int hi = mem[getAddr()];
    int lo = mem[getAddr()+1];
    return ((hi<<8)|(lo&255));
  }
  void set(int v) { //16 bit word WAARDE
    mem[getAddr()] = (v>>8);
    mem[getAddr()+1] = (v&255);
  }
}

Mem8 mem(Reg8 r) {
  return new Mem8(r);
}

Mem16 mem(Reg16 r) {
  return new Mem16(r);
}

Mem16 mem(Reg16 r, int offset) {
  return new Mem16(r, offset);
}

Mem8 mem(Reg8 r, int offset) {
  return new Mem8(r, offset);
}

Mem mem(int v) {
  throw new Error("byte or word implicit");
}

Mem8 mem8(int v) {
  return new Mem8(v);
}

Mem16 mem16(int v) {
  return new Mem16(v);
}

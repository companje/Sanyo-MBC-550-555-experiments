
static class Mem {
  protected static int mem[] = new int[1024*1024];
  static int mem_counter; //incrementing address for memory

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

  void set(int o, int v) {
    throw new Error("Missing Override for Mem.set(offset, value) in subclass");
  }

  int get() {
    throw new Error("Missing Override for Mem.get() in subclass");
  }

  int get(int i) {
    throw new Error("Missing Override for Mem.get(i) in subclass");
  }

  void mov(int v) {
    set(v);
  }

  void mov(Reg r) {
    set(r.get());
  }

  String toString() {
    return (reg!=null ? "["+reg.name+"]=":"") + "["+getAddr()+"]="+get();
  }

  void sub(int v) {
    set(get()-v);
  }

  void add(int v) {
    set(get()+v);
  }

  void inc() {
    set(get()+1);
  }

  void dec() {
    set(get()-1);
  }

  void mult(int v) {
    set(get()*v);
  }

  void div(int v) {
    set(get()/v);
  }

  void mod(int v) {
    set(get()%v);
  }

  void set(int b) {
    set(0, b);
  }
}

static class Mem8 extends Mem {
  Mem8() {
    super(mem_counter);
    mem_counter++;
  }
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
  int get(int i) {
    return mem[getAddr()+i];
  }
  void set(int i, int b) {
    mem[getAddr()+i] = b & 255;
  }
  void setWord(int i, int v) {
    if (v>0xffff) println("Warning: Overflow in mem.setWord("+i+","+v+")");
    mem[getAddr()+i+0] = (v>>8);
    mem[getAddr()+i+1] = (v&255);
  }
}

static class Mem16 extends Mem {
  Mem16() {
    super(mem_counter);
    mem_counter+=2;
  }
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
    //println("mem16 set",v);
    //println(mem_counter);
    if (v>0xffff) println("Warning: Overflow in mem.set("+v+")");
    try {
      mem[getAddr()] = (v>>8);
      mem[getAddr()+1] = (v&255);
    }
    catch (Exception e) {
      println(e);
      e.printStackTrace();
      System.exit(0);
    }
  }
  
  void inc() {
    set(get()+1);
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

//Mem mem(int v) {
//  Thread.dumpStack();
//  throw new Error("byte or word implicit");
//}

Mem8 mem8(int v) {
  return new Mem8(v);
}

Mem16 mem16(int v) {
  return new Mem16(v);
}

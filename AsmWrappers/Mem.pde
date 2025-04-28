//class Offset extends Integer {
//}

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

  Mem(Reg r, Reg r2) {
    throw new Error("Missing Override Mem(r,r)");
  }

  Mem(int v) {
    addr = v;
  }

  int getAddr() {
    return (addr+offset);
  }

  Mem set(int o, int v) {
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
  
  void mov(Mem m) {
    set(m.get());
  }

  String toString() {
    return (reg!=null ? "["+reg.name+"]=":"") + "["+getAddr()+"]="+get();
  }

  void sub(int v) {
    set(get()-v);
  }
  
  void sub(Mem m) {
    set(get()-m.get());
  }

  void add(int v) {
    set(get()+v);
  }
  
  void add(Mem m) {
    set(get()+m.get());
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

  Mem set(int b) {
    return set(0, b);
  }
}

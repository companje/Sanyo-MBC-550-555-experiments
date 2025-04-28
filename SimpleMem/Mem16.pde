
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
  Mem16(int seg, int offset) {
    super(seg, offset);
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

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
  Mem8 set(int i, int b) {
    mem[getAddr()+i] = b & 255;
    return this;
  }
  void setWord(int i, int v) {
    if (v>0xffff) println("Warning: Overflow in mem.setWord("+i+","+v+")");
    mem[getAddr()+i+0] = (v>>8);
    mem[getAddr()+i+1] = (v&255);
  }
}

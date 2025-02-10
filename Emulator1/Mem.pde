int mem[] = new int[1024*1024];

class Mem {  
  Reg reg;
  int addr = 0;    //addr is het geheugenadres
  int offset = 0;
  
  //via set() en get() kan de waarde op het adres worden opgevraagd/ingesteld

  Mem(Reg r) {
    reg = r;
    addr = r.get();    //LET OP: het register bevat het adres. 
  }

  Mem(Reg r, int offset) {
    reg = r;
    addr = r.get();
    this.offset = offset;
  }

  Mem(int v) {
    addr = v;  //adres
  }

  int getAddr() {
    return (addr+offset);
  }

  void set(int v) { //16 bit word WAARDE
    mem[getAddr()] = (v>>8);
    mem[getAddr()+1] = (v&255);
  }

  int get() { //16 bit word WAARDE
    int hi = mem[getAddr()];
    int lo = mem[getAddr()+1];
    return ((hi<<8)|(lo&255));
  }

  int getByte() {
    return mem[getAddr()];
  }

  void setByte(int b) {
    mem[getAddr()] = b & 255;
  }

  String toString() {
    return (reg!=null ? "["+reg.name+"]=":"") + "["+getAddr()+"]="+get();
  }
}

Mem mem(Reg r) {
  return new Mem(r);
}

Mem mem(Reg r, int offset) {
  return new Mem(r, offset);
}

Mem mem(int v) {
  return new Mem(v);
}

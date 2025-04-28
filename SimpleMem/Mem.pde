
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





//Mem mem(int addr) {
//  return new Mem(addr);  
//}

Mem16 mem16(int seg, int i) {
  return new Mem16(seg, i);
}

Mem16 mem16(Reg16 s, int i) {
  return new Mem16(s.get(), i);
}

Mem16 mem16(Reg16 s, Reg16 r) {
  return new Mem16(s.get(), r.get());
}

////Mem mem(Reg r) {
////  println("mem(r)",r);
////  return new Mem(cs,r); //default CS register?
////}

//void mov(Mem m, Reg r) {
//  m.set(r);
//}

//void mov(Mem dst, Mem src) {
//  dst.set(src);
//}

//void movsw() {
//  movsb();
//  movsb();
//}

//void movsb() {
//  mov(mem(es, di), mem(ds, si));
//  inc(si);
//  inc(di);
//}

////void mov(Reg r, Mem m) {
////  r.set(m);
////}

void stosw() {
  mov(mem16(es, di), ax);
  add(di, 2);
}

void stosb() {
  mov(mem(es, di), al);
  inc(di);
}

void lodsb() {
  mov(al, mem(ds,si));
}

void lodsw() {
  mov(ax, mem(ds,si));
}

//class Mem { //abs memory address
//  int addr=0;

//  Mem(Reg seg, Reg reg) {
//    addr = seg.get()*16+reg.get();
//  }
  
//  Mem(int addr) { //absolute
//    this.addr = addr;
//  }

//  Mem(int seg, int i) {
//    addr = seg*16+i;
//  }

//  int getByte() {
//    return mem[addr]&255;
//  }

//  int getWord() {
//    return (mem[addr]<<8) | (mem[addr+1]&255);
//  }

//  void setByte(int v) {
//    mem[addr] = v&255;
//  }

//  void setWord(int v) {
//    mem[addr] = v>>8;
//    mem[addr+1] = v&255;
//  }

//  void set(Mem m) {
//    setByte(m.getByte());
//  }

//  void set(Reg r) {
//    if (r.bits==8) setByte(r.get());
//    else setWord(r.get());
//  }
  
//  //int get() {
//  //  return mem[addr]; 
//  //}
  
//  String toString() {
//    return "[0x"+hex(addr,5)+"]="+mem[addr];
//  }
//}

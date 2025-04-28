class Reg {
  String name;
  int mask; //set by subclass
  int bits;
  int sign;

  Reg(String name) {
    this.name = name;
  }

  void set(Mem m) {
    throw new Error("Missing override for set(m) in subclass");
  }
  
  void set(int v) {
    throw new Error("Missing override for set() in subclass");
  }

  int get() {
    throw new Error("Missing override for get() in subclass");
  }
}


void mov(Reg r, int v) {
  r.set(v);
}

void mov(Reg r, Mem m) {
  r.set(m);
}

void mov(Reg r, Reg r2) {
  r.set(r2.get());
}

void add(Reg r, int v) {
  r.set(r.get()+v);
}

void add(Reg r, Reg r2) {
  r.set(r.get()+r2.get());
}

void add(Reg r, Mem m) {
  r.set(r.get()+m.get());
}

void dec(Reg r) {
  r.set(r.get()-1);
}

void inc(Reg r) {
  r.set(r.get()+1);
}

void shr(Reg r, Reg r2) {
  r.set(r.get() >> r2.get());
}

void shl(Reg r, Reg r2) {
  r.set(r.get() << r2.get());
}

void shr(Reg r, int v) {
  if (v!=1) throw new Error("v should be 1 in shr r,v");
  r.set(r.get() >> 1);
}

void shl(Reg r, int v) {
  if (v!=1) throw new Error("v should be 1 in shl r,v");
  r.set(r.get() << 1);
}

void or(Reg r, Reg r2) {
  r.set(r.get()|r2.get());
}

void xor(Reg r, Reg r2) {
  r.set(r.get()^r2.get());
}

void sub(Reg r, int v) {
  r.set(r.get()-v);
}

void sub(Reg r, Mem m) {
  r.set(r.get()-m.get());
}

void sub(Reg r, Reg r2) {
  r.set(r.get()-r2.get());
}

void mul(Reg r, Reg r2) {
  throw new Error("Missing override for MUL in subclass");
}

void push(Reg r) {
  sp.set(sp.get()-2);
  //println(sp);
  mem(ss,sp).set(r); //.get());
}

void pop(Reg r) {
  mov(r, mem(ss,sp));
  sp.set(sp.get()+2);
}

void cmp(int b) {
  throw new Error("CMP werkt nog niet.");
  //volgens mij gaat hier nog van alles mis
  //DI=100, CMP DI,-50 zou alle flags op 0 moeten zetten toch?
  //int a = get() & mask; // Simuleer 8-bit waarde
  //b = b & mask; // Zorg dat b ook 8-bit is
  //int result = (a - b) & mask; // Simuleer 8-bit resultaat
  //ZF = (result == 0);
  //SF = ((result & sign) != 0); // Kijk naar het hoogste bit van het resultaat
  //CF = Integer.compareUnsigned(a, b) < 0;
  //boolean aNeg = ((a & sign) != 0);
  //boolean bNeg = ((b & sign) != 0);
  //boolean resNeg = ((result & sign) != 0);
  //OF = (aNeg != bNeg) && (aNeg != resNeg);
}



//Reg16 ax = new Reg16("ax");
//Reg16 bx = new Reg16("bx");
//Reg16 cx = new Reg16("cx");
//Reg16 dx = new Reg16("dx");
//Reg16 si = new Reg16("si");
//Reg16 di = new Reg16("di");
//Reg16 bp = new Reg16("bp");
//Reg16 sp = new Reg16("sp");
//Reg16 es = new Reg16("es");
//Reg16 ds = new Reg16("ds");
//Reg16 cs = new Reg16("cs");
//Reg16 ss = new Reg16("ss");
//Reg8 ah = new Reg8("ah");
//Reg8 al = new Reg8("al");
//Reg8 bh = new Reg8("bh");
//Reg8 bl = new Reg8("bl");
//Reg8 ch = new Reg8("ch");
//Reg8 cl = new Reg8("cl");
//Reg8 dh = new Reg8("dh");
//Reg8 dl = new Reg8("dl");

//void mov(Reg a, int b) {
//  a.set(b);
//}

//void mov(Reg a, Reg b) {
//  //println("mov r,r",a,b);
//  a.set(b.get());
//}

//void inc(Reg a) {
//  add(a, 1);
//}

//void dec(Reg a) {
//  sub(a, 1);
//}

//void add(Reg a, int v) {
//  a.set(a.get()+v);
//}

//void sub(Reg a, int v) {
//  a.set(a.get()-v);
//}

//void sub(Reg a, Reg r) {
//  sub(a, r.get());
//}

//void shl(Reg r) {
//  r.set(r.get() << 1);
//}

//void shr(Reg r) {
//  r.set(r.get() >> 1);
//}

//void push(Reg r) {
//  //sub(sp, 2);
//  sp.set(sp.get()-2);
//  //println("sp",sp);
//  //println(mem(ss,sp));
//  mem(ss, sp).set(r);
//}

//void pop(Reg r) {
//  println(ss, sp);
//  mov(r, mem(ss, sp));
//  sp.set(sp.get()+2);
//  //add(sp, 2);
//}

//class Reg8 extends Reg {

//  void set(v) {
//    println("reg set v byte", this, "=", v);
//    Reg regs[] = {ax, bx, cx, dx};
//    Reg reg16 = regs[name.charAt(0)-'a'];
//    boolean hi = name.charAt(1)=='h';
//    int high = hi ? v : reg16.get()>>bits;
//    int low = hi ? reg16.get() : v;
//    println("hi="+hi+",high="+high+",low="+low);
//    int newValue = ((high << bits) | low) & mask;
//    println("newValue", newValue, "for", reg16, "(was)");
//    reg16.set(newValue); // this sets the value of the 16 bit register
//    println("reg16 newValue = ", reg16);
//  }
//}

//class Reg16 extends Reg {
//}

//class Reg {
//  private int value;
//  String name;
//  int mask; //set by subclass
//  int bits;
//  int sign;

//  Reg(String name) {
//    this.name = name;
//    this.bits = (name.charAt(1)=='l'||name.charAt(1)=='h')?8:16;
//    this.mask = bits==16 ? 0xffff : 0xff;
//    this.sign = bits==16 ? 0x8000 : 0x80;
//  }

//  String toString() {
//    return name + "=0x" + hex(value & mask, bits==16?4:2);
//  }

//  void set(Mem m) {
//    println("reg set mem", this);
//    if (bits==8) set(m.getByte());
//    else set(m.getWord());
//  }

//  void set(int v) {
//    //if (bits==8) {
//    //   } else {
//    //println("reg set v word",this);
//    //value = v & mask;
//    //}
//  }

//  int get() {
//    //if (bits==8) {
//    //  Reg regs[] = {ax, bx, cx, dx};
//    //  Reg reg16 = regs[name.charAt(0)-'a'];
//    //  boolean hi = name.charAt(1)=='h';
//    //  int v = (hi ? (reg16.get()>>bits) : (reg16.get() & mask));
//    //  println("reg get",name,v);
//    //  return v;
//    //} else {
//    //  return value & mask;
//    //}
//  }
//}

class Reg {
  String name;
  int mask; //set by subclass
  int bits;
  int sign;

  Reg(String name) {
    this.name = name;
  }

  void set(int v) {
    throw new Error("Missing override for set() in subclass");
  }

  int get() {
    throw new Error("Missing override for get() in subclass");
  }

  void mov(int v) {
    set(v);
  }

  void mov(Mem m) {
    set(m.get());
  }

  void mov(Reg r) {
    set(r.get());
  }

  void add(int v) {
    set(get()+v);
  }
  
  void add(Reg r) {
    set(get()+r.get());
  }

  void add(Mem m) {
    set(get()+m.get());
  }

  void dec() {
    set(get()-1);
  }

  void inc() {
    set(get()+1);
  }

  void shr(Reg b) {
    set(get() >> b.get());
  }

  void shl(Reg b) {
    set(get() << b.get());
  }

  void shr() {
    set(get() >> 1);
  }

  void shl() {
    set(get() << 1);
  }

  void or(Reg b) {
    set(get()|b.get());
  }

  void xor(Reg b) {
    set(get()^b.get());
  }

  void mul(Reg b) {
    throw new Error("Missing override for MUL in subclass");
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
}

Reg16 ax = new Reg16("ax");
Reg16 bx = new Reg16("bx");
Reg16 cx = new Reg16("cx");
Reg16 dx = new Reg16("dx");
Reg16 si = new Reg16("si");
Reg16 di = new Reg16("di");
Reg16 bp = new Reg16("bp");
Reg16 sp = new Reg16("sp");
Reg16 es = new Reg16("es");
Reg16 ds = new Reg16("ds");
Reg16 cs = new Reg16("cs");
Reg16 ss = new Reg16("ss");

class Reg16 extends Reg {
  private int value; //private: don't use directly

  Reg16(String name) {
    super(name);
    mask = 0xffff;
    bits = 16;
    sign = 0x8000;
  }

  String toString() {
    return this.name + "=" + value;
  }

  int get() {
    return value & mask; //nodig als ik geen ints gebruik?
  }

  void set(int v) {
    value = v & mask;
  }

  void mul(Reg16 r) {
    if (this!=ax) throw new Error("MUL16 can only be called on AX");
    long v = (long)ax.get() * (long)r.get();
    ax.set((int)v);
    if (v > mask) {
      dx.set((int)(v>>bits));
    }
  }
}

Reg8 ah = new Reg8("ah");
Reg8 al = new Reg8("al");
Reg8 bh = new Reg8("bh");
Reg8 bl = new Reg8("bl");
Reg8 ch = new Reg8("ch");
Reg8 cl = new Reg8("cl");
Reg8 dh = new Reg8("dh");
Reg8 dl = new Reg8("dl");

class Reg8 extends Reg {
  //Reg8 does not have its own value. It gets/sets the low/high part of the 16 bit register
  boolean hi; //hi=true, lo=false
  Reg16 reg;

  Reg8(String name) {
    super(name);
    mask = 0xff;
    bits = 8;
    sign = 0x80;
    hi = name.charAt(1)=='h';
    Reg16 regs[] = {ax, bx, cx, dx};
    reg = regs[name.charAt(0)-'a'];
  }

  void set(int b) {
    int high = hi ? b : reg.get()>>bits;
    int low = hi ? reg.get() : b;
    reg.set(high << bits | low & mask); // this sets the value of the 16 bit register
  }

  int get() {
    return (hi ? reg.get()>>bits : reg.get() & mask);
  }

  String toString() {
    return this.name + "=" + (hi ? reg.get()>>bits : reg.get() & mask); //cast to unsigned
  }

  void mul(Reg8 r) {
    if (this!=al) throw new Error("MUL8 can only be called on AL");
    int v = al.get() * r.get();
    al.set(v);
    if (v>mask) {
      ah.set(v>>bits);
    }
  }
}

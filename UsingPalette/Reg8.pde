
class Reg8 {
  int value;
  String name;
  int mask = 0xff;
  int bits = 8;
  int sign = 0x80;

  Reg8(String name) {
    this.name = name;
  }

  void set(int v) {
    value = v & mask;
  }

  void mov(int v) {
    set(v);
  }

  void mov(Reg8 r) {
    this.set(r.get());
  }

  void shr(Reg8 r) {
    if (r!=cl) throw new Error("SHR needs CL or 1");
    this.set(this.get()>>r.get());
  }
  
  void shl(Reg8 r) {
    if (r!=cl) throw new Error("SHL needs CL or 1");
    this.set(this.get()<<r.get());
  }
  
  void shr(int v) {
    if (v>1) throw new Error("SHR needs CL or 1");
    this.set(this.get()>>v);
  }
  
  void shl(int v) {
    if (v>1) throw new Error("SHL needs CL or 1");
    this.set(this.get()<<v);
  }
  
  void xor(Reg8 r) {
    this.set(this.get()^r.get());
  }
  
  void neg() {
    this.set(-this.get()); 
  }
  
  void sub(Reg8 r) {
    this.set(this.get()-r.get());
  }
  
  void add(Reg8 r) {
    add(r.get());
  }
  
  void add(int v) {
    this.set(this.get()+v);
  }

  void and(int v) {
    this.set(this.get()&v);
  }

  int get() {
    return value & mask;
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

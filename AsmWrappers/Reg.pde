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

  void shr(int v) {
    assertTrue(v==1, "shr(r,v): v must be 1");
    set(get() >> 1);
  }

  void shl(int v) {
    assertTrue(v==1, "shl(r,v): v must be 1");
    set(get() << 1);
  }

  void or(Reg b) {
    set(get()|b.get());
  }

  void xor(Reg b) {
    set(get()^b.get());
  }

  void sub(int v) {
    set(get()-v);
  }

  void sub(Mem m) {
    set(get()-m.get());
  }

  void sub(Reg r) {
    set(get()-r.get());
  }

  void mul(Reg b) {
    throw new Error("Missing override for MUL in subclass");
  }

  void div(Reg b) {
    throw new Error("Missing override for DIV in subclass");
  }

  void idiv(Reg b) {
    throw new Error("Missing override for IDIV in subclass");
  }

  void push() {
    sp.set(sp.get()-2);
    //println(sp);
    mem(sp).set(get());
  }

  void pop() {
    mov(mem(sp));
    sp.set(sp.get()+2);
  }
  
  boolean jle(Reg r) {
    return get()<=r.get(); 
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

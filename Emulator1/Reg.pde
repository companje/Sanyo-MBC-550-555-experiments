class Reg {
  String name;
  int mask; //set by subclass
  int bits;
  int sign;

  Reg(String name) {
    this.name = name;
  }

  void set(int v) {
    throw new Error("Missing Override for set in subclass");
  }

  int get() {
    throw new Error("Missing Override for get in subclass");
  }

  void add(int v) {
    set(get()+v);
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

  void cmp(int b) { 
    //volgens mij gaat hier nog van alles mis
    //DI=100, CMP DI,-50 zou alle flags op 0 moeten zetten toch?
    
    int a = get() & mask; // Simuleer 8-bit waarde
    b = b & mask; // Zorg dat b ook 8-bit is
    int result = (a - b) & mask; // Simuleer 8-bit resultaat

    ZF = (result == 0);
    SF = ((result & sign) != 0); // Kijk naar het hoogste bit van het resultaat
    CF = Integer.compareUnsigned(a, b) < 0;

    boolean aNeg = ((a & sign) != 0);
    boolean bNeg = ((b & sign) != 0);
    boolean resNeg = ((result & sign) != 0);
    OF = (aNeg != bNeg) && (aNeg != resNeg);
  }
}

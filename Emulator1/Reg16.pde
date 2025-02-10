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
  int value; //private: don't use directly

  Reg16(String name) {
    super(name);
  }

  String toString() {
    return this.name + "=" + value;
  }

  int get() {
    //println("GET16",this);
    return value & 0xffff; //nodig als ik geen ints gebruik?
  }
  
  void set(int v) {
    //println("SET16",this);
    value = v & 0xffff;
  }

  void add(int v) {
    value += v;
  }

  void dec() {
    set(get()-1);
  }

  void inc() {
    value++;
  }
  
  void shr(Reg b) {
    value >>= b.get();
  }

  void shl(Reg b) {
    value <<= b.get();
  }

  void shr() {
    value >>= 1;
  }

  void shl() {
    value <<= 1;
  }

  void or(Reg b) {
    value |= b.get();
  }
  
  void xor(Reg b) {
    value ^= b.get(); 
  }
}

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
    mask = 0xffff;
    bits = 16;
    sign = 0x8000;
  }

  String toString() {
    return this.name + "=" + value;
  }

  int get() {
    return value & 0xffff; //nodig als ik geen ints gebruik?
  }
  
  void set(int v) {
    value = v & 0xffff;
  }


}


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
  
  void idiv(Reg16 r) { //CHECKME
    if (this != ax) throw new Error("IDIV16 can only be called on AX");
    int dividend = (dx.get() << bits) | (ax.get() & mask);
    int divisor = r.get();
    if (divisor == 0) throw new ArithmeticException("Division by zero");

    int quotient = dividend / divisor;
    int remainder = dividend % divisor;

    if (quotient > Short.MAX_VALUE || quotient < Short.MIN_VALUE) {
        throw new ArithmeticException("IDIV overflow");
    }

    ax.set(quotient);
    dx.set(remainder);
}
}

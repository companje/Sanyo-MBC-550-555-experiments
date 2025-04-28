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

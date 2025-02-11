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
  boolean hi;
  Reg reg;

  Reg8(String name) {
    super(name);
    mask = 0xff;
    bits = 8;
    sign = 0x80;
    hi = name.charAt(1)=='h';
    Reg regs[] = {ax, bx, cx, dx};
    reg = regs[name.charAt(0)-'a'];
  }

  void set(int b) {
    //println("SET8",this);
    int high = hi ? b : reg.get()>>8;
    int low = hi ? reg.get() : b;
    reg.set(high<<8 | low&255); // this sets the value of the 16 bit register
  }
  
  int get() {
    //println("GET8",this);
    return (hi ? reg.get()>>8 : reg.get() & 255);
  }

  String toString() {
    return this.name + "=" + (hi ? reg.get()>>8 : reg.get() & 255); //cast to unsigned
  }

}

class MissingOverride extends Error {
  MissingOverride(Object o) {
    super(o.getClass().getSimpleName());
  }
}

class Reg {
  String name;

  Reg(String name) {
    this.name = name;
  }
  void set(int v) {
    throw new MissingOverride(this);
  }
  void add(int v) {
    throw new MissingOverride(this);
  }
  void sub(int v) {
    throw new MissingOverride(this);
  }
  int get() {
    throw new MissingOverride(this);
  }
  void xor(Reg r) {
    throw new MissingOverride(this);
  }
  void or(Reg r) {
    throw new MissingOverride(this);
  }
  void dec() {
    throw new MissingOverride(this);
  }
  void inc() {
    throw new MissingOverride(this);
  }
  void shr(Reg r) {
    throw new MissingOverride(this);
  }
  void shl(Reg r) {
    throw new MissingOverride(this);
  }
  void shr() {
    throw new MissingOverride(this);
  }
  void shl() {
    throw new MissingOverride(this);
  }
}

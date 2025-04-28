void xy_from_angle() { // input: ax=angle, (no magnitude!) output: ax:dx = x:y
  push(ax); // save angle
  sin();
  xchg(dx, ax);
  pop(ax); // restore angle
  cos();
}

int sin() {
  return int(sin(radians(ax.get()))*100);
}

int cos() {
  return int(cos(radians(ax.get()))*100);
}

int atan2() {
  int x = ax.get();
  int y = bx.get();
  return int(degrees(atan2(y,x)));
}

int qsin[] = {
  0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 59, 62, 65, 67, 70, 73, 75, 78, 80, 82, 85, 87, 89, 91, 94, 96, 98, 100, 102, 103, 105, 107, 108, 110, 112, 113, 114, 116, 117, 118, 119, 120, 121, 122, 123, 123, 124, 125, 125, 126, 126, 126, 126, 126
};

void cos256() {
  al.sub(64);
  sin256();
}

void sin256() {
  cl.mov(6);
  dl.mov(al); //dl=angle 0..255
  dl.shr(cl); //angle/6 = quadrant 0..3
  dh.mov(dl); //dh=copy of quadrant
  dh.and(1);  //dh=1 if quadrant is odd 1 or 3
  bl.mov(dh); //bl=dh
  bl.shl(cl); //r = bl<<6
  ch.mov(dl); //gt1
  ch.shr(1);
  bl.sub(dh); //s (0 of 63)
  al.and(63); //i
  al.xor(bl); //i^bl
  al.mov(qsin[al.get()]); //mov bx,qsin, xlat
  ch.neg();
  al.xor(ch);
  ch.neg();
  al.add(ch);
  al.add(128);
}

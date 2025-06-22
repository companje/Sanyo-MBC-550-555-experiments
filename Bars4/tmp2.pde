
int calcColor(int y, int frame, int ch_index, int offset) {
  al.set(ch_index);
  al.add(ch_index);
  al.add(ch_index);
  al.add(frame);
  al.add(offset);
  sine256();
  int barY = (al.get() * 192) >> 8; //scale 0..255 to 0..192
  if (y < barY) return 0;
  if (y > barY + 10) return 0;
  return 255;
}

void drawLine(int di, int ch, int v) {
  for (int i = 0; i < COLS*4; i+=4) { //was i<COLS*4
    mem[channels[ch] + di + i] = v;
  }
}

void draw_img(PImage img) {
  int row = di.get() / 288;
  int col = di.get() % 288;
  image(img, col*8/4, row*8, img.width, img.height*2);
}

void set_cursor(int row, int col) {
  di.set( (row-1) * BYTES_PER_ROW + (col-1) * 4 ); // one based
}

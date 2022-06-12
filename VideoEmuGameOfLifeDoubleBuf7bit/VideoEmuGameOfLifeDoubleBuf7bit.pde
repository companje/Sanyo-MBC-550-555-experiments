





void draw() {
  if (mousePressed) {
    line(pmouseX, pmouseY,mouseX, mouseY);
    return;
  }
  loadPixels();
  PImage p=get();
  for (int i=0, x=0, y=0, n=0, w=100, h=100; i<w*h; i++, x=i%w, y=i/w, n=0) {
    for (int j=0; j<9; j++)
      n+=p.get((x+j%3-1+w)%w, (y+j/3-1+h)%h)/color(0);
    if (n==3|n!=4) pixels[i]=color(n==3?0:255);
  }
  updatePixels();
}

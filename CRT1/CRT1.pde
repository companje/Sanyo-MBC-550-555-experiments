void setup() {
  fullScreen(2);
  noStroke();
}

void draw() {
  int bgColor = int(map(sin(frameCount*.1), -1, 1, 0, 255));

  background(bgColor);

  fill(255-bgColor);

  int x = int(sin(frameCount*.001)*width);
  int y = int(sin(frameCount*.001)*height);

  rect(x, 0, 100, height);
  rect(0, y, width, 200);
}

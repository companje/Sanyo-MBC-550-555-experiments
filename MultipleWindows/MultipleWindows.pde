void setup() {
  fullScreen();
  background(0);
  frameRate(10);
}

void draw() {
  if (frameCount<=9) App.create(frameCount-1);
  background(0);
}

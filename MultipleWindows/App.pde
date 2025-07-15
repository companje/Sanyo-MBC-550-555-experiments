public static class App extends PApplet {
  int id, vx, vy, vw, vh;

  App(int id, int vx, int vy, int vw, int vh) {
    super();
    this.id = id;
    this.vx = vx;
    this.vy = vy;
    this.vw = vw;
    this.vh = vh;

    PApplet.runSketch(new String[] { this.getClass().getName() }, this);
  }

  static void create(int f) {
    new App(f, (f%3)*400+150, (f/3)*300+50, 400, 300);
  }

  void settings() {
    fullScreen();
    smooth(0);
  }

  void setup() {
    windowMove(vx, vy);
    windowResize(vw, vh);
    //windowResizable(false);
  }

  void draw() {
    background(0, 20, 0);
  }
}

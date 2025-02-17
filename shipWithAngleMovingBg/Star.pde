public class Star extends Particle {
  float s;

  Star(float x, float y) {
    this.set(x, y);
    this.s = random(2, 6);
  }

  void update() {
    if (y-player.y > world_h-height) y-=world_h;
    if (y-player.y < -height) y+=world_h;
    if (x-player.x > world_w-width) x-=world_w;
    if (x-player.x < -width) x+=world_w;
  }

  void draw() {
    float xx = -player.x+x+width/2;
    float yy = -player.y+y+height/2;

    if (yy>0 && yy<height && xx>0 &&  xx<width) { //in view 
      app.image(star[(int)map(s, 2, 6, 0, 3)], xx,yy);
    }
  }
}

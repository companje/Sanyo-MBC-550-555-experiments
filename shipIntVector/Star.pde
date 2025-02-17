public class Star extends Particle {
  float s;

  Star() {
    set(random(0, world_w), random(0, world_h));
    s = random(2, 6);
  }

  void update() {
    warp(this);
  }

  void draw() {
    float xx = x-player.x+width/2;
    float yy = y-player.y+height/2;

    if (yy>0 && yy<height && xx>0 &&  xx<width) { //in view 
      image(img_star[(int)map(s, 2, 6, 0, 3)], xx,yy);
    }
  }
}

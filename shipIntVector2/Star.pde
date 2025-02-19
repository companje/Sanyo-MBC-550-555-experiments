public class Star {
  Vector pos = new Vector();
  float s;

  Star() {
    pos.set((int)random(0, world_w), (int)random(0, world_h));
    s = random(2, 6);
  }

  void update() {
    warp(pos);
  }

  void draw() {
    float xx = pos.x-player.pos.x+width/2;
    float yy = pos.y-player.pos.y+height/2;

    if (yy>0 && yy<height && xx>0 &&  xx<width) { //in view 
      image(img_star[(int)map(s, 2, 6, 0, 3)], xx,yy);
    }
  }
}

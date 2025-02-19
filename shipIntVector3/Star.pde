public class Star {
  Vector pos = new Vector();
  float s;

  Star() {
    pos.set((int)random(0, world_w.get()), (int)random(0, world_h.get()));
    s = random(2, 6);
  }

  void update() {
    warp(pos);
  }

  void draw() {
    float xx = pos.x-player.pos.x+screen_w.get()/2;
    float yy = pos.y-player.pos.y+screen_h.get()/2;

    if (yy>0 && yy<screen_h.get() && xx>0 &&  xx<screen_w.get()) { //in view 
      int star_index = (int)map(s, 2, 6, 0, 3);
      //image(img_star[star_index], xx,yy);
      
      //world2screen();
      //calc_di_from_bx();
      set_cursor(int(yy/height*50), int(xx/width*72));
      draw_img(img_star[star_index]);
    
    }
  }
}

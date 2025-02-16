public class Star extends Particle {
  float s;
  int c;

  Star(float x, float y) {
    this.set(x, y);
    this.s = random(2, 6);
    this.c = color(255);
  }

  void update() {
    //float mindist=500;
    //float maxdist=1000;
    //if (this.dist(player)>maxdist) {
    //  do {
    //    x = player.x+random(-width*2, width*2);
    //    y = player.y+random(-height*2, height*2);
    //  } while (this.dist(player)<mindist);
    //}
    //warp_world(this);

    if (y-player.y > world_h-height) y-=world_h;
    if (y-player.y < -height) y+=world_h;
    if (x-player.x > world_w-width) x-=world_w;
    if (x-player.x < -width) x+=world_w;
  }

  void draw() {
    float xx = -player.x+x+width/2;
    float yy = -player.y+y+height/2;

    boolean inView = yy>0 && yy<height && xx>0 && xx<width; 

    if (!inView) return;

    app.pushMatrix();
    app.translate(xx, yy);
    app.image(star[(int)map(s, 2, 6, 0, 3)], 0, 0);
    //app.text(int(xx)+","+int(yy),0,0);
    app.popMatrix();
  }
}

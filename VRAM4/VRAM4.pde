PImage img, img2;
PGraphics pg;
int COLS=80;
int BYTES_PER_ROW=8*COLS;  //  25 lines
int mem[] = new int[1024*1024];
int R=0xf0000, G=0x0C000, B=0xf4000;
int w=640, h=400, hd2=h/2, wd2=w/2;
int rgb[] = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255) };
float xoff = 0.0;
int xx=0;
int oy=0;

void setup() {
  size(640, 400);
  img = createImage(COLS*8, 200, RGB);
  pg = createGraphics(width, height); //img.width, img.height); //fbo
}

void draw() {
  clearAll();

  //ellipse(noise(frameCount/2)*width;



  pg.beginDraw();
  pg.clear();
  //pg.stroke(255);
  //pg.background(204);
  //pg.stroke(rgb[(frameCount%3)]);
  //pg.line(n, 0, n, height);
  pg.fill(255);

  for (int x=0; x<width; x++) {
    //xoff = xoff + .01;
    float n =  sin(x*.3+frameCount*.01)*sin(x*.1+frameCount*.01)*300;    
    pg.fill(rgb[0]);
    pg.ellipse(x,oy+height-n, 8, 8);

    n =  sin(x*.3+frameCount*.01+.2)*sin(.2+x*.1+frameCount*.01)*300;    
    pg.fill(rgb[1]);
    pg.ellipse(x,oy+height-n, 8, 8);

n =  sin(x*.3+frameCount*.01+.8)*sin(.8+x*.1+frameCount*.01)*300;    
    pg.fill(rgb[2]);
    pg.ellipse(x,oy+height-n, 8, 8);


    //pg.fill(rgb[1]);
    //pg.ellipse(x,oy+height-n-8, 8, 8);
    //pg.fill(rgb[2]);
    //pg.ellipse(x,oy+height-n-16, 8, 8);
    
    //xx++;
  }
      //oy++;

 

  //  //float x = sin(i*.1)*400;
  //  //pg.rect(x, sin(frameCount*.025+i*.05)*hd2+hd2, w-2*x, 2);

  pg.endDraw();
  img2 = pg.get();
  img2.resize(img.width, img.height);
  setMemoryFromImage(img2);
  //}

  setImageFromMemory(img);
  image(img, 0, 0, width, height);
}

void keyPressed() {
  if (key=='c') clearAll();
}

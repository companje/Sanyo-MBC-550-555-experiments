import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;

int o[] = new int[64];
String s = "";

void setup() {
  size(800, 400);
  noSmooth();
  PImage img = loadImage("/Users/rick/Documents/Processing/TixyChar/tixy-dots2.png");
  scale(3);
  image(img, 0, 0);

  for (int row=0; row<img.height/8; row++) {
    for (int x=0, i=0; x<16; x++) {
      for (int y=0; y<4; y++, i++) {
        o[i] = 0;
        for (int q=0; q<8; q++) {
          o[i] += brightness(img.get(x*16+q, row*8+y))>0 ? 1<<(7-q) : 0;
        }
        if (y==0) s+="    db ";
        s+=o[i]+(y==3?"\n":",");
      }
    }
    byte[] b = new byte[o.length];
    for (int i = 0; i < o.length; i++) b[i] = (byte)(o[i] & 0xFF);
    saveBytes("tixy"+row+".bin", b);
  }

  //println(s);
  //Toolkit.getDefaultToolkit().getSystemClipboard().setContents(new StringSelection(s), null);

  //byte[] b = new byte[o.length];
  //for (int i = 0; i < o.length; i++) b[i] = (byte)(o[i] & 0xFF);
  //saveBytes("tixy.bin", b);
}

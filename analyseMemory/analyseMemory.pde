import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.Toolkit;

byte bytes[];
int COLS=72, ROWS=50;
byte memory[] = new byte[20000];
int pc = 0;
String cb = "";

void setup() {
  noSmooth();
  size(576, 400);
}

void updateMemory(String s) {
  pc=0;
  for (int i=0; i<memory.length; i++) memory[i]=0;
  String lines[] = s.split("\n");
  //println(lines.length, "lines");
  for (String line : lines) {
    if (line.length()<12) continue;
    String ll = line.substring(11);
    int threeSpaces = ll.indexOf("   ");
    if (threeSpaces==-1) continue;
    ll = ll.substring(0, threeSpaces);
    for (String col : split(ll, ' ')) {
      if (col.equals("")) continue;
      else memory[pc++] = (byte)(unhex(col)&255);
    }
  }
}

void draw() {
  try {
    Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
    Transferable content = clipboard.getContents(null);
    if (content != null && content.isDataFlavorSupported(DataFlavor.stringFlavor)) {
      String clipboardText = (String) content.getTransferData(DataFlavor.stringFlavor);
      if (!clipboardText.equals(cb)) {
        cb = clipboardText;
        println("nieuwe clipboard data");
        for (int i=0; i<min(20, cb.length()); i++) {
          //println(i, int(cb.charAt(i)));
        }
        if (cb.length()>4 && cb.substring(0, 4).equals("    ")) {
          updateMemory(clipboardText);
          
          //draw
          background(0);
          scale(2, 2);
          for (int y=0, i=0; y<12; y++) {
            for (int x=0; x<8; x++, i++) {
              int offset = i*192;
              print(hex(offset,4)+" ");
              image(getImageFromBytes(memory, offset, 32, 16), x*32, y*16);
            }
          }
          println();
        }
      }
    }
  }
  catch (IOException e) {
    println(e);
  }
  catch (UnsupportedFlavorException e) {
    println(e);
  }
}

PImage getImageFromBytes(byte[] bytes, int offset, int w, int h) { //w,h in pixels - 3 channel image
  PImage img = createImage(w, h, RGB);
  img.loadPixels();
  for (int y=0, bit=128, j=0; y<h; y++) {
    for (int x=0; x<w; x++, bit=128>>(x%8)) {
      int i = int(y/4)*(w/2)+(y%4)+int(x/8)*4 + offset;
      int r = (bytes[i+0*w/8*h] & bit)>0 ? 255 : 0;
      int g = (bytes[i+1*w/8*h] & bit)>0 ? 255 : 0;
      int b = (bytes[i+2*w/8*h] & bit)>0 ? 255 : 0;
      img.pixels[j++] = color(r, g, b);
    }
  }
  img.updatePixels();
  return img;
}

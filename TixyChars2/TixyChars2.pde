PFont font;
PGraphics pg;
int fontSize = 400;
char chars[] = {'·','•','•',0xF9,0xFA};
char charset[] = new char[255];
String charstring = "☺☻♥♦♣♠•◘○◙♂♀♪♫☼►◄↕‼¶§▬↨↑↓→←∟↔▲▼";
//#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~⌂ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ¢£¥₧ƒáíóúñÑªº¿⌐¬½¼¡«»░▒▓│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌█▄▌▐▀αßΓπΣσµτΦΘΩδ∞φε∩≡±≥≤⌠⌡÷≈°∙·√ⁿ²■ ";
//char charset[] = {'☺'};
//char character = '·'; //·•*■0O';
int index=0;


void setup() {
  size(334, 400);
  for (int i=0; i<charset.length; i++) charset[i]=char(i);
  
  frameRate(3);
  
  font = createFont("Ac437_SanyoMBC55x",fontSize,false,charset);
  //font = loadFont("Ac437_SanyoMBC55x-80.vlw");
}

void draw() {
  background(0);
  textFont(font);
  char c = charstring.charAt(index); //frameCount%charstring.length());
  //char c = chars[index];
  text(c,0,fontSize-fontSize/8);
  
  //textFont(
  //image( drawChar('☺'), 0, 0);
}

void keyPressed() {
 if (key==']') index++;
 if (key=='[') index--;
 index = int(constrain(index,0,charstring.length()-1));
}

//PImage drawChar(char ch) {
//  pg.beginDraw();
//  pg.background(0);
//  pg.fill(255);
//  pg.textFont(font);
//  pg.textAlign(LEFT, TOP);
//  pg.text(ch, 0, 0);
//  pg.endDraw();
//  pg.loadPixels();

//  PGraphics p2 = createGraphics(400, 400);
//  p2.beginDraw();
//  p2.background(0);
//  p2.fill(255);
//  p2.stroke(255,0,0);

//  for (int y = 0; y < fontSize; y++) {
//    for (int x = 0; x < fontSize; x++) {
//      color c = pg.pixels[y * fontSize + x];
//      int brightness = int(brightness(c));
//      if (brightness>200) {
//        p2.rect(x*50,y*50, 50, 50);
//      }
//      //print(brightness > 128 ? "#" : ".", " ");
//    }
//    //println();
//  }
//  p2.endDraw();
//  //pg.filter(POSTERIZE,3);
//  //return pg;
//  //return;
//  return p2;
//}

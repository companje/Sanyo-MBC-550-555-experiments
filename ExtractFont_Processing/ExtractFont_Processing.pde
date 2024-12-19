byte[] file;
PImage img;

void settings() {
  noSmooth();
  size(1152, 850);
}

void setup() {
  img = createImage(576, 200, RGB);
  file = loadBytes("BANDIT.EXE");
  
  //clear_offset_count(file, 0x0000, 0x0014);     //MZ header
  //clear(file, 0x0C30, 64*192); //sprites: key till bandit
  //clear(file, 0x3C4E, 40*192); //sprites: donut till scorpion
  //clear(file, 0x7753, 984);    //strings
  //clear(file, 0x7E0A, 1656);   //strings
  //clear(file, 0x6CF0, 1583);   //strings
  //clear(file, 0x8BBB, 1167);   //strings
  //clear(file, 0x3C20, 0x002E); //0+NCN@NLNONRNUNFNI01
  //clear(file, 0x627A, 0x0018); //string 1234567890123456789012345
  //clear(file, 0x7393, 0x03BF); //strings TREES, CACTI, THE TIMEGATES ...
  //clear(file, 0x0297, 0x0081); //code
  //clear(file, 0x08D1, 0x0293); //code
  //clear(file, 0x84A1, 0x0477); //code
  //clear(file, 0x90DB, 0x003F); //code
  //clear(file, 0x914A, 0x1E4C); //code
  //clear(file, 0xAF96, 0x0012); //string?
  //clear(file, 0x0338, 0x08A8); //font

  
  
//}

//void draw() {
 
//  image(img, 0, 0, width, height);
//}

//void mouseWheel(MouseEvent event) {
//  float e = event.getCount();
//  offset = int(constrain(offset+e*4*72, 0, file.length-COLS*LINES));
//  println(offset, "0x"+hex(offset, 4));
//}

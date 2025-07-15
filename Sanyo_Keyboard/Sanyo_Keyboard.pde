import processing.serial.*;
Serial serial;

//boolean ctrl = false;
int keys[] = new int[255];
int keyCodes[] = new int[255];

void setup() {
  keys['\n'] = '\r';
  keyCodes[SHIFT] = -1;
  keyCodes[CONTROL] = -1;
  keyCodes[UP] = 30;
  keyCodes[LEFT] = 28;
  keyCodes[DOWN] = 31;
  keyCodes[RIGHT] = 29;
  keyCodes[112] = 16; //PF1
  keys[3] = 3;

  serial = new Serial(this, "/dev/tty.usbmodem101", 115200);
}

void draw() {
}

void keyPressed() {
  boolean coded = (key==CODED);
  int k = coded ? keyCode : key;

  println(coded, k);

  if (coded) {
    if (keyCodes[k]!=0) k = keyCodes[k];
  } else {
    if (keys[k]!=0) k = keys[k];
  }

  if (k!=-1) serial.write(k);
}

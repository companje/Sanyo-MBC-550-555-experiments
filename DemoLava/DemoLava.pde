int numLines = 256;
int lineWidth = 320;
float[] sinTable;
int sinLen = 256;
float d0 = 0;
float d1 = 0;
float deltaA = 2;
float deltaB = 4;

void setup() {
  size(lineWidth, numLines);
  noStroke();
  sinTable = new float[sinLen];
  for (int i = 0; i < sinLen; i++) {
    float angle = TWO_PI * i / sinLen;
    sinTable[i] = sin(angle) * 64;
  }
  frameRate(60);
}

void draw() {
  background(0);
  
  for (int y = 0; y < numLines; y++) {
    int i0 = ((int)d0 + y * (int)deltaA) % sinLen;
    int i1 = ((int)d1 + y * (int)deltaB) % sinLen;
    int i2 = (i0 + i1) % sinLen;
    int offset = (int)(sinTable[i2] + lineWidth / 2);
    
    offset = constrain(offset, 0, lineWidth);
    fill(255);
    rect(offset, y, lineWidth - offset, 1);
  }

  d0 = (d0 + deltaA) % sinLen;
  d1 = (d1 + deltaB) % sinLen;
}

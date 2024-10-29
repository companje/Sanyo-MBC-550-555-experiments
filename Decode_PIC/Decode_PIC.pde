size(640,400);
noStroke();

//load and check width
byte bytes[] = loadBytes("eleven.pic");
int w = (bytes[1]<<8) + (bytes[0] & 0xff);
int h = (bytes[3]<<8) + (bytes[2] & 0xff);

//check and fix width if needed
//int bytesPerChannel = (bytes.length-4)/3;
//if (w*h/8<bytesPerChannel) 
//  w = (int(w+8)/8)*8;

//draw
for (int i=0, x=0, y=0, n=w*h/8; i<n; i++) {
  for (int j=128; j>0; j/=2, x=(x+1)%w, y=i/(w/8)) {
    int rr=(bytes[i+2*n+4]&j)/j<<8;
    int gg=(bytes[i+1*n+4]&j)/j<<8;
    int bb=(bytes[i+0*n+4]&j)/j<<8;
    fill(rr, gg, bb);
    rect(x, y*2, 1, 1.75); //double height, with slight vertical raster line in between the lines
  }
}

get(0,0,w,int(h*1.75)).save("eleven.PNG");

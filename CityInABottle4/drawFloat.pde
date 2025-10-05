
//void drawFloat() {
//  int x = i%w; // Ray direction in world space.
//  int y = i/w;

//  float a=x*.02-1;
//  float b=1-y*.025;

//  float s=b; //bg
//  float d=1; //light

//  float X=t, Y=1, Z=2;

//  // Ray tracing!
//  for (; Z<w; Z++) {
//    if (isThereAnythingAt(int(X), int(Y), int(Z), int(t))) { //Hit model, now continue ray tracing toward the light
//      float last_d = d;
//      s=(int(X)&int(Y)&int(Z))%3; //The texture.
//      s/=Z; // Fog.
//      a=b=1; // New direction, toward the light.
//      d=Z/w;
//      if (last_d < 1) break;
//    }
//    X+=a;
//    Y-=b;
//  }
//  float darkness = 1.05-(s+1-d*Z/w); // Texture + lighting.

//  fill(int(darkness*32)/32. * 255);
//  rect(x, y, 1, 1);

//  if (c++>n) { //pixel counter
//    c=0;
//    t++;
//  }

//  i+=step;
//  if (i>n) i-=n;
//}

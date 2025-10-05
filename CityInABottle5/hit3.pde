//void hit() { //int X, byte Y, byte Z) { //scaled
//  //ax = xs;
//  //ax += t;
//  //cl = BUILDING_WIDTH;
//  //al = div8(ax, cl);
//  //bl = zs;
//  //cl = BUILDING_DEPTH;
//  //bl/=cl; //fixme.. swap before div8
//  //al^=bl;

//  //ax = al;  //xor ah,ah
//  //ax <<= 3; //*=8
//  //cl = BUILDING_HEIGHT;
//  //ax &= 31; // mod8(ax, cl);

//  ax = xs;
//  //cbw
//  ax += t; //370
//  cl = 9; //BUILDING_WIDTH
//  al = (byte)(ax/cl); //div8(ax, cl);
//  //cbw
//  bl = zs;
//  cl = 3; 
//  bl >>= cl; // bl/=8 (BUILDING_DEPTH)
//  al ^= bl;
//  ax = al;
//  //cbw
//  //ax <<= cl; // ax*=8
//  //cl = 45; //BUILDING_HEIGHT
//  //ax = (byte)(ax%cl); //mod8(ax, cl);
//  //ax &=31;
//  ax <<= cl; // ax*=8
//  cl = 45;
//  ax = (byte)(ax%cl); //mod8(ax, cl);

//stack.push(ax); //modifier

//  //stack.push((ax == 0) ? 0 : 1) ; //condition3
//  //stack.push(1);

//  stack.push((zs <= 34) ? 0 : 1); //condition1

//  //ax = xs;
//  //ax += t;
//  //ax %= 99;
//  //stack.push((ax <= 27) ? 0 : 1); //condition2
//  //stack.push(1);

//  //ax = 1; //stack.pop();
//  //bx = 1; //stack.pop();
//  //ax &= bx;
//  ax = 1;
//  bx = stack.pop();
//  ax &= bx;
//  bx = stack.pop(); //combined modifier

//  if (ax==0) bx=0; //modifier in bx. if conditions not met then 0 (no hit yet)


//  ax = ys;
//  ax -= 6;
//  ax += bx;

//  sf = ax<0;
//}

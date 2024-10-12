int index=0; //index
byte bytes[];

HashMap<Integer, Line> lines = new HashMap();
PrintWriter out;

void setup() {
  out = createWriter("out.bas");

  loadFunctions();

  bytes = loadBytes("WRITEASM.BAS"); //DEMO-tokenized.BAS");

  readShort(); //ignore first 2 bytes

  Line line = readLine();
  while (line!=null) { // && line.nr<1300) {
    //println(line.nr, hexdump(line.s));
    if (line!=null) {
      try {
        line.parse();
        out.println(line.nr + " "+line.r);
        println(line.nr + " "+line.r);
        line = readLine(); //next one
      }
      catch (Exception e) {
        println(line.r);
        println("ERROR", e);
        System.exit(0);
      }
    }
  }

  out.close();
}

Line readLine() {
  int l = readShort();
  if (l==0) return null; //last line
  Line line = new Line();
  line.nr=l;
  int n = readShort();

  int until = index+n;
  while (index<until) {
    line.s+=char(bytes[index++]);
    //i++;
  }
  //line.s = trim(line.s);
  return line;
}

int readShort() {
  int a = bytes[index+0] & 0xff;
  int b = bytes[index+1] & 0xff;
  int r = (b<<8)|a;
  index+=2;
  return r;
}

String hexdump(String s) {
  String parts[] = new String[s.length()];
  for (int i=0; i<s.length(); i++) {
    char c = s.charAt(i);
    if (c<32 || c>127) parts[i] = "["+hex(c, 2)+"]";
    else parts[i] = c+"";
  }
  return join(parts, "");
}

void draw() {
  exit();
}

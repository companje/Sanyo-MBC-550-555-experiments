int index=0; //index
byte bytes[];

HashMap<Integer, Line> lines = new HashMap();
PrintWriter out;
ArrayList<Function> fns = new ArrayList();

class Function {
  int a, b;
  String name;
}

void setup() {

  loadFunctions();

  bytes = loadBytes("bas/FIETS.BAS"); //input
  out = createWriter("bas/FIETS-detok.bas"); //output

  readShort(); //ignore first 2 bytes

  Line line = readLine();
  while (line!=null) { // && line.nr<1300) {
    //println(line.nr, hexdump(line.s));
    if (line!=null) {
      //try {
      line.parse();
      out.print(line.nr + " "+line.r + "\r\n");
      println(line.nr + " "+line.r);
      line = readLine(); //next one
      //}
      //catch (Exception e) {
      //  println(line.r);
      //  println("ERROR", e);
      //  System.exit(0);
      //}
    }
  }

  out.write(0x1a); //EOF
  out.close();
}

Line readLine() {
  int l = readShort();
  if (l==0) return null; //last line
  Line line = new Line();
  line.nr=l;
  int n = readShort();
  //println("n",n);
  //if (n>100) n=1;

  int until = index+n;
  while (index<until) {
    if (index>bytes.length-1) {
      println("Error in readLine");
      line.s = "";
      return line;
    }
    line.s+=char(bytes[index]);
    index++;
  }
  //line.s = trim(line.s);
  return line;
}

int readShort() {
  int r = readShortAt(index);
  index+=2;
  return r;
}

int readShortAt(int i) {
  if (i>bytes.length-1) {
    println("readShortAt",i);
    return 0;
  }
  int a = bytes[i+0] & 0xff;
  int b = bytes[i+1] & 0xff;
  return (b<<8)|a;
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

class Line {
  int nr;
  String s="";
  String r="";

  void parse() {

    for (int i=0; i<s.length(); i++) {
      char a = s.charAt(i);
      char b = 0;

      if (a==0x11) { //16bit hex constant
        r+="&H" + (hex((byte)s.charAt(i+2), 2) + hex((byte)s.charAt(i+1), 2)).replaceFirst("^0+(?!$)", ""); //concat + remove leading zero's
        i+=2;
      } else if (a==0x18) { //64bit double
        //r+=parse_float64(s.substring(i+1, i+9).toCharArray());
        r+="{{FLOAT64}}";
        i+=8;
      } else if (a==0x14) {
        r+=parse_float32(s.substring(i+1, i+5).toCharArray());
        i+=4;
      } else if (a==0x12 || a==0x1e) { //16 bit integer
        b = s.charAt(i+1);
        char c = s.charAt(i+2);
        i+=2;
        r+= (c<<8|b);
      } else if (a==0xff) { //function 2 bytes
        b = s.charAt(i+1);
        Function f = getFunction(a, b);
        r+= f.name + "";
        i++; //extra ivm b
      } else if (a>=0x80 && a<=0xe9) { //function 1 byte
        r += getFunction(a).name;
      } else if (a==0x0D) {
        //ignore line break
      } else if (a>=32 && a<=127) {
        r+=a+"";
      } else {
        println("Unknown char: 0x" + hex(a, 2));
        //System.exit(0);
      }
    }
  }

  String parse_float32(char[] data) {
    if (data[3] == 0) return "0!";
    int exp = data[3] - 152;  // -152 = -128 + -24 (24 because the significand is behind a decimal dot)
    int mantissa = ((data[2] | 0x80) << 16) | (data[1] << 8) | data[0];
    float number = mantissa * pow(2, exp);
    number = round(mantissa * pow(2, exp) * 1000000f) / 1000000f;
    return canonize_number(number+"");
  }

  //String parse_float64(char[] data) {
  //  if (data[7] == 0) return "0!";
  //  int exp = data[7] - 184;  // -184 = -128 + -56 (56 because the significand is behind a decimal dot)
  //  int mantissa = ((data[6] | 0x80) << 48) | (data[5] << 40) | (data[4] << 32) | (data[3] << 24)| (data[2] << 16) | (data[1] << 8) | data[0];
  //  float number = mantissa * pow(2, exp);
  //  //number = round(mantissa * pow(2, exp) * 1000000f) / 1000000f;
  //  return canonize_number(number+"");
  //  //String.format("%s",number)
  //}

  String canonize_number(String num) {
    num = num.replaceAll("^([\\-])*0\\.", "$1."); //\1.
    num = num.replaceAll("\\.0$", "");
    return num.toUpperCase();
  }
}

Function getFunction(int a, int b) {
  for (Function f : fns) {
    if (f.a==a && f.b==b) return f;
  }
  return null;
}

Function getFunction(int a) {
  for (Function f : fns) {
    if (f.a==a) return f;
  }
  return null;
}

void loadFunctions() {
  //PrintWriter out = createWriter("fn.txt");
  String lines[] = loadStrings("functions.txt");
  for (String line : lines) {
    Function f = new Function();
    f.a = line.charAt(line.length()-2) & 0xff;
    f.b = line.charAt(line.length()-1) & 0xff;
    //f.nr = (b<<8)|a;
    f.name = line.substring(0, line.length()-2);
    //println(hex(f.nr,4),f.name);
    //out.println(hex(f.a, 2) + " " + hex(f.b, 2) + " " + f.name);
    fns.add(f);
  }
  //out.flush();
  //out.close();
}

void draw() {
  exit();
}

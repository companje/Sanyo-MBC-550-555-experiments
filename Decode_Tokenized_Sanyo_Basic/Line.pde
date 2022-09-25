class Line {
  int nr;
  String s="";
  String r="";

  void parse() {

    Function f;

    for (int i=0; i<s.length(); i++) {
      char a = s.charAt(i);
      char b = 0;

      if (a==0x11) { //16bit hex constant
        r+="{{HEX CONSTANT}}";
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
        f = getFunction(a, b);
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
        System.exit(0);
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
    //String.format("%s",number)
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

class Function {
  int a, b;
  String name;
}

ArrayList<Function> fns = new ArrayList();

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
  PrintWriter out = createWriter("fn.txt");
  String lines[] = loadStrings("functions.txt");
  for (String line : lines) {
    Function f = new Function();
    f.a = line.charAt(line.length()-2) & 0xff;
    f.b = line.charAt(line.length()-1) & 0xff;
    //f.nr = (b<<8)|a;
    f.name = line.substring(0, line.length()-2);
    //println(hex(f.nr,4),f.name);
    out.println(hex(f.a, 2) + " " + hex(f.b, 2) + " " + f.name);
    fns.add(f);
  }
  out.flush();
  out.close();
}

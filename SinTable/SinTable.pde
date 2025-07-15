
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;

String s = "";
for (int i=0,n=64; i<n; i++) {
  //println(sin(float(i)/n*HALF_PI));
  s+=int(map(sin(float(i)/n*HALF_PI),0,1,0,127))+",";  
}

Toolkit.getDefaultToolkit().getSystemClipboard().setContents(new StringSelection(s), null);

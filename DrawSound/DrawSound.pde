import java.util.Arrays;
import ddf.minim.*;
import ddf.minim.ugens.*;

HashMap<Integer, Integer> points = new HashMap<Integer, Integer>();
Minim minim;
AudioOutput out;
Oscil osc;
boolean isPlaying = false;

void setup() {
  size(1500,900);
  background(0);
  stroke(255);
  noFill();
  
  // Initialize Minim
  minim = new Minim(this);
  out = minim.getLineOut();
  osc = new Oscil(440, 0.5f, Waves.SINE);
  osc.patch(out);
  
  byte[] bytes = loadBytes("waveform.dat");
  if (bytes != null && bytes.length >= 2) { // At least one y-value (2 bytes)
    for (int i = 0; i < bytes.length/2 && i < width; i++) {
      // Read y value from two bytes
      int y = ((bytes[i*2 + 1] & 0xFF) << 8) | (bytes[i*2 + 0] & 0xFF);
       if (y > 0) {  // Only add points that have a value
         points.put(i, y);
       }
    }
  }

  playWaveform();

}

void draw() {
  background(0);
  scale(4);

  mouseX/=4;
  mouseY/=4;

  for (int x = 0; x < width; x+=20) {
    stroke(50);
    line(x,0,x,height);
  }
  
  if (mousePressed) {
    int x = (int)constrain(mouseX, 0, width-1);
    points.put(x, mouseY);
  }
  
  if (points.size() > 0) {
    stroke(255);
    beginShape();
    // Convert points to array for sorting
    Integer[] xPoints = points.keySet().toArray(new Integer[0]);
    Arrays.sort(xPoints);
    // Draw points in order
    for (int x : xPoints) {
      vertex(x, points.get(x));
    }
    endShape();
  }
}

void keyPressed() {
  if (key=='c') points.clear();
  if (key=='s') save();
  if (key==' ') playWaveform();
}

void playWaveform() {
  if (!isPlaying) {
    isPlaying = true;
    
    // Read the waveform data
    byte[] bytes = loadBytes("waveform.dat");
    if (bytes != null && bytes.length >= 2) {
      // Create thread to play tones
      Thread playThread = new Thread(new Runnable() {
        public void run() {
          osc.setAmplitude(0.5);
          
          // Play each point for 1ms
          for (int i = 0; i < bytes.length/2 && isPlaying && i < width; i++) {
            // Read y value from two bytes
            int y = ((bytes[i*2 + 1] & 0xFF) << 8) | (bytes[i*2 + 0] & 0xFF);
            // Map y value (500-0) to frequency (500Hz-5kHz)
            float freq = map(y, 500, 0, 500, 5000);
            
            if (freq > 0) {
              osc.setFrequency(freq);
              try {
                Thread.sleep(2);  // Play for 1ms
              } catch (InterruptedException e) {
                break;
              }
            }
          }
          
          isPlaying = false;
          osc.setAmplitude(0);
        }
      });
      
      playThread.start();
    }
  } else {
    isPlaying = false;
    osc.setAmplitude(0);
  }
}

void save() {
  byte[] bytes = new byte[width * 2];
  
  if (points.size() > 0) {
    // Convert points to array for sorting
    Integer[] xPoints = points.keySet().toArray(new Integer[0]);
    Arrays.sort(xPoints);
    
    // Handle points before first clicked point
    for (int x = 0; x < xPoints[0]; x++) {
      int y = points.get(xPoints[0]);
      bytes[x*2 + 1] = byte((y >> 8) & 0xFF);     // high byte
      bytes[x*2 + 0] = byte(y & 0xFF);        // low byte
    }
    
    // Interpolate between points
    for (int i = 0; i < xPoints.length - 1; i++) {
      int x1 = xPoints[i];
      int x2 = xPoints[i + 1];
      int y1 = points.get(x1);
      int y2 = points.get(x2);
      
      // Store the first point
      bytes[x1*2 + 1] = byte((y1 >> 8) & 0xFF);
      bytes[x1*2 + 0] = byte(y1 & 0xFF);
      
      // Interpolate points between x1 and x2
      for (int x = x1 + 1; x < x2; x++) {
        float t = (x - x1) / (float)(x2 - x1);
        int y = (int)lerp(y1, y2, t);
        bytes[x*2 + 1] = byte((y >> 8) & 0xFF);
        bytes[x*2 + 0] = byte(y & 0xFF);
      }
    }
    
    // Handle last point and remaining points
    int lastX = xPoints[xPoints.length - 1];
    int lastY = points.get(lastX);
    for (int x = lastX; x < width; x++) {
      bytes[x*2 + 1] = byte((lastY >> 8) & 0xFF);
      bytes[x*2 + 0] = byte(lastY & 0xFF);
    }
  } else {
    // If no points, fill with zeros
    for (int x = 0; x < width; x++) {
      bytes[x*2 + 1] = 0;
      bytes[x*2 + 0] = 0;
    }
  }
  
  saveBytes("waveform.dat", bytes);
}

void stop() {
  out.close();
  minim.stop();
  super.stop();
}

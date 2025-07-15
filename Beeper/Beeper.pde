import javax.sound.sampled.*;

byte[] rom;
int pos = 0;
int loopStart = 1000;
int loopEnd = 1100;
int sampleRate = 44100;
boolean looping = true;

void setup() {
  rom = loadBytes("mbc55x-v120.rom");
  new Thread(() -> playClick()).start();
}

void draw() {
}

void playClick() {
  while (true) {
    int sampleRate = 44100;
    AudioFormat format = new AudioFormat(sampleRate, 8, 1, true, false);
    try {
      SourceDataLine line = AudioSystem.getSourceDataLine(format);
      line.open(format);
      line.start();

      byte[] buffer = new byte[100000];
      
      for (int i = 1; i < buffer.length; i++) {
        buffer[i] = byte(i%frameCount); // rest stil
      }

      //for (int i = buffer.length; i < buffer.length; i++) {
      //  buffer[i] = 0; // rest stil
      //}

      line.write(buffer, 0, buffer.length);
      line.drain();
      line.stop();
      line.close();
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }
}

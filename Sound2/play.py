import numpy as np
import sounddevice as sd
import sys
from scipy.io.wavfile import write

SAMPLE_RATE = 8000

def load_inc_file(filename):
    with open(filename, "r") as f:
        text = f.read()

    if 'db' in text:
        text = text.split('db', 1)[1]
    bytes_ = [int(b.strip()) for b in text.strip().split(',') if b.strip().isdigit()]
    return bytes_

def expand_bytes_to_audio(bytes_):
    audio = []
    for byte in bytes_:
        for i in range(8):
            bit = (byte >> i) & 1
            audio.append(1.0 if bit else -1.0)
    return np.array(audio, dtype=np.float32)


def play_bitstream(bytes_, sample_rate):
    audio = expand_bytes_to_audio(bytes_)
    sd.play(audio, samplerate=sample_rate)
    sd.wait()
    write(sys.argv[1].replace(".inc",".python.wav"), sample_rate, audio)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python play.py file.inc")
        sys.exit()
    bytestream = load_inc_file(sys.argv[1])
    play_bitstream(bytestream, sample_rate=SAMPLE_RATE)

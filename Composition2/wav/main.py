import numpy as np
import sounddevice as sd
from scipy.io.wavfile import write

def play_bitstream(bits, sample_rate, filename):
    audio = np.array([1.0 if bit else -1.0 for bit in bits], dtype=np.float32)
    sd.play(audio, samplerate=sample_rate)
    sd.wait()
    write(filename, sample_rate, audio)

bits = [1, 0, 1, 1, 0, 0, 1] * 1000
play_bitstream(bits, 8000 , 'output.wav')

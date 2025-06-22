import numpy as np
import sounddevice as sd

def play_raw_pcm(file_path, samplerate=44100, dtype='uint8'):
    with open(file_path, 'rb') as f:
        raw_data = f.read()
    audio = np.frombuffer(raw_data, dtype=dtype)
    sd.play(audio, samplerate)
    sd.wait()

play_raw_pcm('data/drums44k1.pdm')

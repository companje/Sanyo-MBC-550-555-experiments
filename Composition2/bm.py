import numpy as np
import sounddevice as sd
import scipy.io.wavfile as wavfile

sample_rate = 44100
duration = 2.0

def square_wave(freq, duration, sample_rate):
    t = np.linspace(0, duration, int(sample_rate * duration), endpoint=False)
    wave = 0.5 * np.sign(np.sin(2 * np.pi * freq * t))
    return wave

def normalize_uint8(wave):
    wave = wave / np.max(np.abs(wave))
    wave = (wave + 1) * 127.5
    return wave.astype(np.uint8)

b_freq = 246.94
d_freq = 293.66
fsharp_freq = 369.99

b_wave = square_wave(b_freq, duration, sample_rate)
d_wave = square_wave(d_freq, duration, sample_rate)
fsharp_wave = square_wave(fsharp_freq, duration, sample_rate)

chord = b_wave + d_wave + fsharp_wave
uint8_chord = normalize_uint8(chord)

sd.play((uint8_chord.astype(np.float32) - 128) / 128.0, samplerate=sample_rate)
sd.wait()

wavfile.write('bm_chord_square.wav', sample_rate, uint8_chord)

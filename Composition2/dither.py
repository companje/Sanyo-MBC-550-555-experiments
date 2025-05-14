import wave
import numpy as np

def load_wav(filename):
    with wave.open(filename, 'rb') as wf:
        frames = wf.readframes(wf.getnframes())
        samples = np.frombuffer(frames, dtype=np.int16)
        if wf.getnchannels() == 2:
            samples = samples[::2]
        return samples.astype(np.float32) / 32768.0

def floyd_steinberg_1bit(samples):
    output = np.zeros_like(samples, dtype=np.uint8)
    err = 0.0
    for i in range(len(samples)):
        val = samples[i] + err
        bit = 1 if val >= 0 else 0
        output[i] = bit
        quantized = 1.0 if bit else -1.0
        error = val - quantized
        if i + 1 < len(samples):
            samples[i + 1] += error * 7 / 16
        if i + 2 < len(samples):
            samples[i + 2] += error * 1 / 16
    return output

def save_bin(output, filename):
    packed = np.packbits(output)
    with open(filename, 'wb') as f:
        f.write(packed.tobytes())

samples = load_wav('wav/falle-vocals-44kHz.wav')
samples = samples[:len(samples) - len(samples) % 8]  # align to full bytes
bitstream = floyd_steinberg_1bit(samples)
save_bin(bitstream, 'bin/falle-vocals-44kHz-dither.bin')

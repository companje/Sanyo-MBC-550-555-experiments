import numpy as np
import wave

def load_bitstream(filename):
    data = np.frombuffer(open(filename, 'rb').read(), dtype=np.uint8)
    bits = np.unpackbits(data)
    return bits

# def bitstream_to_wave(bitstream, sample_rate=8000, samples_per_bit=10):
#     output = np.zeros(len(bitstream) * samples_per_bit, dtype=np.int16)
#     for i, bit in enumerate(bitstream):
#         value = 10000 if bit else -10000
#         output[i * samples_per_bit : (i + 1) * samples_per_bit] = value
#     return output

def bitstream_to_wave(bitstream, sample_rate=8000, samples_per_bit=5):
    output = np.repeat(bitstream * 2 - 1, samples_per_bit) * 10000
    return output.astype(np.int16)

def save_wave(samples, filename, sample_rate=8000):
    with wave.open(filename, 'wb') as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(sample_rate)
        wf.writeframes(samples.astype(np.int16).tobytes())

bitstream = load_bitstream('bin/wonderful-days-vocals-dither.bin')
samples = bitstream_to_wave(bitstream, sample_rate=8000, samples_per_bit=5)
save_wave(samples, 'wav/wonderful-days-vocals-dither.restored.wav', sample_rate=8000)

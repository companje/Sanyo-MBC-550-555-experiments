import numpy as np
from scipy.io import wavfile
from scipy.signal import resample
import sys

TARGET_SAMPLE_RATE = 8000

def wav_to_bitstream(wav_file, threshold=0.0):
    sample_rate, data = wavfile.read(wav_file)
    print(sample_rate)

    if len(data.shape) > 1:
        data = data[:, 0]  # mono

    if data.dtype == np.int16:
        data = data.astype(np.float32) / 32768.0
    elif data.dtype == np.int32:
        data = data.astype(np.float32) / 2147483648.0
    elif data.dtype == np.uint8:
        data = (data.astype(np.float32) - 128) / 128.0
    elif data.dtype == np.float32:
        pass
    else:
        raise ValueError("Unsupported audio format")

    # resample naar 8000 Hz als nodig
    # if sample_rate != TARGET_SAMPLE_RATE:
    #     num_samples = int(len(data) * TARGET_SAMPLE_RATE / sample_rate)
    #     data = resample(data, num_samples)

    # bits = (data > threshold)
    bits = (data > 0).astype(np.uint8)
    return bits

def pack_bits_to_bytes(bits):
    pad_len = (8 - len(bits) % 8) % 8
    bits = np.pad(bits, (0, pad_len), constant_values=0)
    bytes_ = []
    for i in range(0, len(bits), 8):
        byte = 0
        for j in range(8):
            if bits[i + j]:
                byte |= (1 << j)
        bytes_.append(byte)
    return bytes_

def save_to_inc_file(byte_array, filename):
    with open(filename, "w") as f:
        f.write("sound: db ")
        f.write(",".join(str(b) for b in byte_array))
    print(f"Opgeslagen als {filename}")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Gebruik: python convert_wav.py input.wav output.inc")
        sys.exit(1)

    wav_file = sys.argv[1]
    out_file = sys.argv[2]

    bitstream = wav_to_bitstream(wav_file)
    byte_array = pack_bits_to_bytes(bitstream)
    save_to_inc_file(byte_array, out_file)

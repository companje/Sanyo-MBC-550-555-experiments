import numpy as np
from scipy.io import wavfile
from scipy.signal import resample
import sys
import sounddevice as sd

# TARGET_SAMPLE_RATE = 8000

def wav_to_bitstream(wav_file, threshold=0.0):
    sample_rate, data = wavfile.read(wav_file)

    if len(data.shape) > 1:
        data = data[:, 0]

    if data.dtype == np.uint8:
        data = (data.astype(np.float32) - 128) / 128.0
    else:
        raise ValueError("Unsupported audio format. uint8 expected")

    return (data > threshold).astype(np.uint8)

def pack_bits_to_bytes(bits):
    return np.packbits(bits, bitorder='little').tolist()

def save_to_bin_file(byte_array, filename):
    length = len(byte_array)
    if length>0xffff:
        length=0xffff

    with open(filename, "wb") as f:
        f.write(length.to_bytes(2, byteorder='little'))
        f.write(bytearray(byte_array))

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Gebruik: python wav2bin.py input.wav output.bin [threshold]")
        sys.exit(1)

    wav_file = sys.argv[1]
    out_file = sys.argv[2]
    threshold = float(sys.argv[3]) if len(sys.argv)==4 else 0

    bitstream = wav_to_bitstream(wav_file, threshold)

    # audio_signal = bitstream.astype(np.float32) * 2 - 1
    # sd.play(audio_signal, fs)
    # sd.wait()


    byte_array = pack_bits_to_bytes(bitstream)
    save_to_bin_file(byte_array, out_file)


# import numpy as np
# from scipy.io import wavfile
# from scipy.signal import resample
# import sys

# TARGET_SAMPLE_RATE = 8000

# def wav_to_bitstream(wav_file, threshold=0.0):
#     sample_rate, data = wavfile.read(wav_file)

#     if len(data.shape) > 1:
#         data = data[:, 0]

#     if data.dtype == np.uint8:
#         data = (data.astype(np.float32) - 128) / 128.0
#     else:
#         raise ValueError("Unsupported audio format. uint8 expected")

#     return (data > threshold).astype(np.uint8)

# def pack_bits_to_bytes(bits):
#     pad_len = (8 - len(bits) % 8) % 8
#     bits = np.pad(bits, (0, pad_len), constant_values=0)
#     return np.packbits(bits, bitorder='little').tolist()

# def save_to_bin_file(byte_array, filename):
#     with open(filename, "wb") as f:
#         f.write(bytearray(byte_array))

# if __name__ == "__main__":
#     if len(sys.argv) < 3:
#         print("Gebruik: python wav2bin.py input.wav output.bin [threshold]")
#         sys.exit(1)

#     wav_file = sys.argv[1]
#     out_file = sys.argv[2]
#     threshold = float(sys.argv[3]) if len(sys.argv)==4 else 0

#     bitstream = wav_to_bitstream(wav_file, threshold)
#     byte_array = pack_bits_to_bytes(bitstream)
#     save_to_bin_file(byte_array, out_file)

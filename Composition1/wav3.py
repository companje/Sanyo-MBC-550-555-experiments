import numpy as np
from scipy.io import wavfile
import sounddevice as sd

def wav_to_bitstream(wav_file, threshold=0.0):
    sample_rate, data = wavfile.read(wav_file)
    if len(data.shape) > 1:
      data = data[:, 0]
    data = (data.astype(np.float32) - 128) / 128.0
    return (data > threshold).astype(np.uint8), sample_rate

bitstream, sample_rate = wav_to_bitstream("wav/wdays-vocals.wav", 0)
audio_signal = bitstream.astype(np.float32) * 2 - 1
sd.play(audio_signal, sample_rate)
sd.wait()
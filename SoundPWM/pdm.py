import numpy as np
from scipy.io import wavfile

def wav_to_pdm(input_wav, output_bin):
    sample_rate, data = wavfile.read(input_wav)
    if data.ndim > 1:
        data = data[:, 0]
    data = data.astype(np.float32)
    data /= np.max(np.abs(data))

    accumulator = 0.0
    pdm_data = []

    for sample in data:
        accumulator += sample
        if accumulator >= 0:
            pdm_data.append(1)
            accumulator -= 1.0
        else:
            pdm_data.append(0)
            accumulator += 1.0

    packed_bytes = np.packbits(pdm_data)
    with open(output_bin, 'wb') as f:
        f.write(packed_bytes)

wav_to_pdm('data/drums32pcm.wav', 'data/drums.pdm')

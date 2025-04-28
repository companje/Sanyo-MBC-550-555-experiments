import numpy as np

SAMPLE_RATE = 8000

def to_bytes_from_bits(bits):
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

def generate_waveform(freq, duration_sec, sample_rate, waveform='square'):
    total_samples = int(duration_sec * sample_rate)
    t = np.arange(total_samples) / sample_rate
    phase = 2 * np.pi * freq * t

    if waveform == 'square':
        wave = np.sign(np.sin(phase))
    elif waveform == 'saw':
        wave = 2 * (t * freq % 1) - 1
    elif waveform == 'triangle':
        wave = 2 * np.abs(2 * (t * freq % 1) - 1) - 1
    elif waveform == 'sine':
        wave = np.sin(phase)
    else:
        raise ValueError(f"Unsupported waveform: {waveform}")

    bits = (wave > 0).astype(np.uint8)
    return to_bytes_from_bits(bits)

def generate_enveloped_tone(freq, duration_sec, sample_rate, attack=0.01, decay=0.05, sustain=0.7, release=0.1, waveform='square'):
    total_samples = int(duration_sec * sample_rate)
    t = np.arange(total_samples) / sample_rate
    envelope = np.zeros_like(t)

    a_end = int(attack * sample_rate)
    d_end = a_end + int(decay * sample_rate)
    r_start = total_samples - int(release * sample_rate)

    envelope[:a_end] = np.linspace(0, 1, a_end, endpoint=False)
    envelope[a_end:d_end] = np.linspace(1, sustain, d_end - a_end, endpoint=False)
    envelope[d_end:r_start] = sustain
    envelope[r_start:] = np.linspace(sustain, 0, total_samples - r_start, endpoint=True)

    phase = 2 * np.pi * freq * t
    wave = np.sign(np.sin(phase)) if waveform == 'square' else np.sin(phase)
    modulated = wave * envelope

    bits = (modulated > 0).astype(np.uint8)
    return to_bytes_from_bits(bits)

def generate_arpeggio(frequencies, note_duration, total_duration, sample_rate, waveform='square'):
    cue = []
    time = 0.0
    while time < total_duration:
        for freq in frequencies:
            if time >= total_duration:
                break
            tone = generate_waveform(freq, note_duration, sample_rate, waveform)
            cue.extend(tone)
            time += note_duration
    return cue

def save_to_inc_file(cue, filename):
    length = len(cue)
    header = [length & 0xFF, (length >> 8) & 0xFF]
    full = header + cue
    with open(filename, "w") as f:
        f.write("sound: db ")
        f.write(",".join(str(b) for b in full))
    print(f"Opgeslagen als {filename} (lengte: {length} bytes + header)")

if __name__ == "__main__":
    save_to_inc_file(
        generate_waveform(freq=440, duration_sec=1.0, sample_rate=SAMPLE_RATE, waveform='saw'),
        "saw.inc"
    )

    save_to_inc_file(
        generate_waveform(freq=440, duration_sec=1.0, sample_rate=SAMPLE_RATE, waveform='triangle'),
        "triangle.inc"
    )

    save_to_inc_file(
        generate_enveloped_tone(freq=440, duration_sec=1.0, sample_rate=SAMPLE_RATE, attack=0.05, decay=0.1, sustain=0.4, release=0.2),
        "envelope.inc"
    )

    save_to_inc_file(
        generate_arpeggio([440, 660, 880], note_duration=0.1, total_duration=1.2, sample_rate=SAMPLE_RATE, waveform='square'),
        "arpeggio.inc"
    )

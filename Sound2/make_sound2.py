import numpy as np

SAMPLE_RATE = 8000

def generate_ramp_up_cue(start_freq, end_freq, duration_sec, sample_rate):
    total_samples = int(duration_sec * sample_rate)
    cue = []
    phase = 0.0

    for i in range(total_samples // 8):
        t = i / (total_samples // 8)
        freq = start_freq + (end_freq - start_freq) * t
        samples_per_cycle = sample_rate / freq
        samples_per_half = samples_per_cycle / 2

        byte = 0
        for bit in range(8):
            bit_value = 1 if phase < samples_per_half else 0
            byte |= (bit_value << bit)
            phase += 1
            if phase >= samples_per_cycle:
                phase = 0
        cue.append(byte)

    return cue

def generate_constant_tone(freq, duration_sec, sample_rate):
    total_samples = int(duration_sec * sample_rate)
    cue = []
    phase = 0.0
    samples_per_cycle = sample_rate / freq
    samples_per_half = samples_per_cycle / 2

    for i in range(total_samples // 8):
        byte = 0
        for bit in range(8):
            bit_value = 1 if phase < samples_per_half else 0
            byte |= (bit_value << bit)
            phase += 1
            if phase >= samples_per_cycle:
                phase = 0
        cue.append(byte)

    return cue

def generate_noise(duration_sec, sample_rate, density=0.5):
    total_samples = int(duration_sec * sample_rate)
    cue = []
    rng = np.random.default_rng()

    bits = rng.random(total_samples) < density
    bits = bits.astype(np.uint8)

    pad_len = (8 - len(bits) % 8) % 8
    bits = np.pad(bits, (0, pad_len))

    for i in range(0, len(bits), 8):
        byte = 0
        for j in range(8):
            if bits[i + j]:
                byte |= (1 << j)
        cue.append(byte)

    return cue

def save_to_inc_file(cue, filename):
    length = len(cue)
    length_low = length & 0xFF
    length_high = (length >> 8) & 0xFF
    full_data = [length_low, length_high] + cue

    with open(filename, "w") as f:
        f.write("sound: db ")
        f.write(",".join(str(byte) for byte in full_data))
    print(f"Opgeslagen als {filename} (lengte: {length} bytes + header)")

if __name__ == "__main__":
    save_to_inc_file(
        generate_ramp_up_cue(start_freq=100, end_freq=5000, duration_sec=1.0, sample_rate=SAMPLE_RATE),
        "ramp_up_sound.inc"
    )

    save_to_inc_file(
        generate_ramp_up_cue(start_freq=5000, end_freq=100, duration_sec=1.0, sample_rate=SAMPLE_RATE),
        "ramp_down_sound.inc"
    )

    save_to_inc_file(
        generate_constant_tone(freq=1000, duration_sec=.1, sample_rate=SAMPLE_RATE),
        "1khz.inc"
    )

    save_to_inc_file(
        generate_noise(duration_sec=0.05, sample_rate=SAMPLE_RATE, density=.95),
        "beat0.05x.95.inc"
    )

    save_to_inc_file(
        generate_noise(duration_sec=0.1, sample_rate=SAMPLE_RATE, density=0.2),
        "hi_hat.inc"
    )

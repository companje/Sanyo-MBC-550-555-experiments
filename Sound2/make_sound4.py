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

def generate_noise(duration_sec, sample_rate, density=0.5):
    total_samples = int(duration_sec * sample_rate)
    rng = np.random.default_rng()
    bits = (rng.random(total_samples) < density).astype(np.uint8)
    return to_bytes_from_bits(bits)

def generate_beat(duration_sec=0.1, sample_rate=SAMPLE_RATE):
    return generate_noise(duration_sec, sample_rate, density=0.4)

def generate_beat_pulse(repeats=4, beat_duration=0.1, rest_duration=0.15, sample_rate=SAMPLE_RATE):
    beat = generate_noise(beat_duration, sample_rate, density=0.6)
    rest_len = int(rest_duration * sample_rate)
    rest_bits = [0] * rest_len
    rest = to_bytes_from_bits(rest_bits)

    sequence = []
    for _ in range(repeats):
        sequence.extend(beat)
        sequence.extend(rest)
    return sequence

def generate_tone_with_beats(
    tone_freq=440,
    tone_duration=0.2,
    beat_duration=0.08,
    repeats=5,
    sample_rate=SAMPLE_RATE
):
    sequence = []
    for _ in range(repeats):
        tone = generate_waveform(tone_freq, tone_duration, sample_rate, waveform='square')
        beat = generate_beat(beat_duration, sample_rate)
        sequence.extend(tone)
        sequence.extend(beat)
    return sequence

def save_to_inc_file(cue, filename):
    length = len(cue)
    header = [length & 0xFF, (length >> 8) & 0xFF]
    full = header + cue
    with open(filename, "w") as f:
        f.write("sound: db ")
        f.write(",".join(str(b) for b in full))
    print(f"Opgeslagen als {filename} (lengte: {length} bytes + header)")

note_freqs = {
    'c': 261.63,
    'd': 293.66,
    'e': 329.63,
    'f': 349.23,
    'g': 196.00,
    'a': 220.00,
    'b': 246.94
}

def generate_note(note, duration, sample_rate):
    freq = note_freqs[note.lower()]
    return generate_waveform(freq, duration, sample_rate, waveform='square')

def generate_intro_sequence(patterns, note_duration=0.12, sample_rate=SAMPLE_RATE):
    cue = []
    for group in patterns:
        for note in group:
            cue.extend(generate_note(note, note_duration, sample_rate))
    return cue

def generate_string_chord(notes, duration, sample_rate, waveform='triangle'):
    t = np.linspace(0, duration, int(sample_rate * duration), endpoint=False)
    wave = np.zeros_like(t)
    for note in notes:
        freq = note_freqs[note.lower()]
        phase = 2 * np.pi * freq * t
        if waveform == 'square':
            wave += np.sign(np.sin(phase))
        elif waveform == 'saw':
            wave += 2 * (t * freq % 1) - 1
        elif waveform == 'triangle':
            wave += 2 * np.abs(2 * (t * freq % 1) - 1) - 1
        elif waveform == 'sine':
            wave += np.sin(phase)
    wave /= len(notes)  # gemiddeld volume

    bits = (wave > 0).astype(np.uint8)
    return to_bytes_from_bits(bits)

def generate_string_intro_chords(chord_list, duration=0.6, sample_rate=SAMPLE_RATE, waveform='triangle'):
    cue = []
    for chord in chord_list:
        cue.extend(generate_string_chord(chord, duration, sample_rate, waveform))
    return cue

def generate_drumroll(
    beat_duration=0.05,
    start_interval=0.3,
    end_interval=0.05,
    steps=20,
    sample_rate=SAMPLE_RATE,
    density=0.5,
    include_final_hit=True
):
    cue = []
    intervals = np.linspace(start_interval, end_interval, steps)

    for interval in intervals:
        beat = generate_noise(beat_duration, sample_rate, density)
        rest_samples = int((interval - beat_duration) * sample_rate)
        rest = to_bytes_from_bits([0] * max(rest_samples, 0))
        cue.extend(beat)
        cue.extend(rest)

    if include_final_hit:
        final = generate_noise(0.12, sample_rate, density=0.7)
        cue.extend(final)

    return cue

def generate_piano_note_duty(freq, duration_sec=0.6, sample_rate=SAMPLE_RATE, start_duty=0.6, end_duty=0.1):
    total_samples = int(duration_sec * sample_rate)
    samples_per_cycle = sample_rate / freq
    wave = np.zeros(total_samples)

    for i in range(total_samples):
        cycle_pos = i % samples_per_cycle
        t = i / total_samples
        duty = start_duty + (end_duty - start_duty) * t  # lineair aflopend
        if (cycle_pos / samples_per_cycle) < duty:
            wave[i] = 1
        else:
            wave[i] = -1

    bits = (wave > 0).astype(np.uint8)
    return to_bytes_from_bits(bits)

def combine_tracks(tracks):
    """ Combine multiple byte lists into one by layering their bits. """
    max_len = max(len(track) for track in tracks)
    layers = [track + [0] * (max_len - len(track)) for track in tracks]
    combined = []
    for i in range(max_len):
        byte = 0
        for layer in layers:
            byte |= layer[i]
        combined.append(byte)
    return combined

def make_sections(patterns, chord_duration=0.6, arp_duration=0.25, beat_rest=0.25):
    result = []
    for chord in patterns:
        pad = generate_string_chord(chord, duration=chord_duration, sample_rate=SAMPLE_RATE)
        arp = generate_intro_sequence([chord], note_duration=arp_duration)
        beat = generate_beat_pulse(repeats=1, beat_duration=0.025, rest_duration=beat_rest)
        section = combine_tracks([pad, arp, beat])
        result.extend(section)
    return result

def generate_flute_note(freq, duration_sec=0.6, sample_rate=SAMPLE_RATE, vibrato_rate=5.0, vibrato_depth=0.01):
    t = np.linspace(0, duration_sec, int(sample_rate * duration_sec), endpoint=False)

    # Vibrato: sinusvormige pitch modulatie
    vibrato = np.sin(2 * np.pi * vibrato_rate * t) * vibrato_depth
    current_freq = freq * (1 + vibrato)
    phase = 2 * np.pi * current_freq * t
    wave = np.sin(phase)

    # Zachte attack
    attack_len = int(0.02 * sample_rate)
    envelope = np.ones_like(wave)
    envelope[:attack_len] = np.linspace(0, 1, attack_len)
    wave *= envelope

    bits = (wave > 0).astype(np.uint8)
    return to_bytes_from_bits(bits)


def build_intro_song():
    intro = make_sections(['gcec', 'gcec', 'gbdb', 'gbdb', 'adfd', 'adfd', 'acec', 'acec','gcec', 'gcec', 'gbdb', 'gbdb', 'adfd', 'adfd', 'acec', 'acec'])

    verse = make_sections(['gcec', 'gcec', 'gbdb', 'gbdb', 'adfd', 'adfd', 'acec', 'acec', 'gcec', 'gcec', 'gbdb', 'gbdb', 'adfd', 'adfd', 'acec', 'acec'], chord_duration=0.5, arp_duration=0.08, beat_rest=0.4)


    bridge_chords = ['gdfg', 'ceac', 'gbdb']
    bridge = make_sections(bridge_chords, chord_duration=0.5, arp_duration=0.08, beat_rest=0.3)

    # De laatste bridge-akkoord mét drumroll erdoorheen
    final_bridge_chord = 'gggg'
    bridge_pad = generate_string_chord(final_bridge_chord, duration=0.6, sample_rate=SAMPLE_RATE)
    bridge_arp = generate_intro_sequence([final_bridge_chord], note_duration=0.1)
    bridge_beat = generate_beat_pulse(repeats=1, beat_duration=0.05, rest_duration=0.55)
    roll = generate_drumroll(beat_duration=0.04, start_interval=0.25, end_interval=0.05, steps=20, include_final_hit=False)
    roll = roll[:len(bridge_pad)]  # match length
    bridge_climax = combine_tracks([bridge_pad, bridge_arp, bridge_beat, roll])

    # Nu een stevige beat (vier keer per maat, 4/4 stijl)
    beat_groove = []
    for _ in range(4):
        beat_groove.extend(generate_beat_pulse(repeats=1, beat_duration=0.06, rest_duration=0.15))

    chorus = make_sections(['cegc', 'aceg', 'cegc', 'aceg'], chord_duration=0.6, arp_duration=0.1, beat_rest=0.5)
    chorus_with_beat = combine_tracks([chorus, beat_groove * 2])  # herhaal beat

    outro = generate_string_chord("fac", duration=0.8, sample_rate=SAMPLE_RATE)

    full_song = intro + verse + verse + bridge + bridge_climax + chorus_with_beat + outro
    return full_song

def generate_bell_note(freq, duration_sec=.3, sample_rate=SAMPLE_RATE):
    t = np.linspace(0, duration_sec, int(sample_rate * duration_sec), endpoint=False)

    # Boventonen mix: toon + octaaf + boventoon + 'detune'
    wave = (
        1.0 * np.sin(2 * np.pi * freq * t) +
        0.5 * np.sin(2 * np.pi * freq * 2 * t) +
        0.3 * np.sin(2 * np.pi * freq * 2.62 * t) +  # inharmonic overtone
        0.2 * np.sin(2 * np.pi * (freq * 0.99) * t)   # lichte detune
    )

    # Bell-like envelope: sharp attack, long decay
    attack_len = int(0.005 * sample_rate)
    release_len = int(duration_sec * sample_rate) - attack_len
    envelope = np.concatenate([
        np.linspace(0, 1, attack_len, endpoint=False),
        np.linspace(1, 0, release_len)
    ])
    wave *= envelope

    bits = (wave > 0).astype(np.uint8)
    return to_bytes_from_bits(bits)




if __name__ == "__main__":
    save_to_inc_file(
        generate_tone_with_beats(tone_freq=440, tone_duration=0.2, beat_duration=0.08, repeats=6),
        "tone_with_beat.inc"
    )

    save_to_inc_file(
        generate_beat_pulse(repeats=6, beat_duration=0.1, rest_duration=0.15),
        "strong_beat.inc"
    )

    intro_pattern = ['gcec', 'gcec', 'gbdb', 'gbdb', 'adfd', 'adfd', 'acec', 'acec']
    save_to_inc_file(
        generate_intro_sequence(intro_pattern, note_duration=0.12),
        "intro_arpeggio.inc"
    )

    chords = ['gcec', 'gcec', 'gbdb', 'gbdb', 'adfd', 'adfd', 'acec', 'acec']
    save_to_inc_file(
        generate_string_intro_chords(chords, duration=0.6, waveform='triangle'),
        "intro_strings.inc"
    )

    save_to_inc_file(
        generate_drumroll(
            beat_duration=0.04,
            start_interval=0.25,
            end_interval=0.05,
            steps=25,
            include_final_hit=True
        ),
        "drumroll.inc"
    )

    save_to_inc_file(
        generate_piano_note_duty(freq=261.63),  # C4
        "piano_duty_c4.inc"
    )

    save_to_inc_file(
        build_intro_song(),
        "full_song_structured.inc"
    )

    save_to_inc_file(
        generate_flute_note(freq=523.25),  # C5, helder fluitje
        "flute_c5.inc"
    )

    save_to_inc_file(
        generate_bell_note(freq=880),  # A5-ish
        "bell_a5.inc"
    )
import os
import re
from pydub import AudioSegment
import parselmouth
import numpy as np
import math

NOTE_NAMES = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

def hz_to_note(freq):
    if freq <= 0:
        return "?"
    A4 = 440.0
    semitones_from_A4 = 12 * math.log2(freq / A4)
    midi_note = round(semitones_from_A4 + 69)
    octave = midi_note // 12 - 1
    note_index = midi_note % 12
    return f"{NOTE_NAMES[note_index]}{octave}"

def detect_pitch(path):
    snd = parselmouth.Sound(path)
    pitch = snd.to_pitch(time_step=0.01, pitch_floor=50, pitch_ceiling=10000)
    values = pitch.selected_array['frequency']
    values = values[values > 0]
    return np.median(values) if len(values) > 0 else 0

def build_note_fragment_map(fragment_dir):
    mapping = {}
    for file in os.listdir(fragment_dir):
        if file.endswith(".wav"):
            path = os.path.join(fragment_dir, file)
            pitch = detect_pitch(path)
            note = hz_to_note(pitch)
            if note != "?":
                mapping[note.upper()] = path
    return mapping

def parse_note_string(s, default_octave=4):
    blocks = s.strip().split()
    all_notes = []
    for block in blocks:
        i = 0
        while i < len(block):
            ch = block[i].lower()
            if ch < 'a' or ch > 'g':
                i += 1
                continue
            if i + 1 < len(block) and block[i + 1] == '#':
                note = ch.upper() + '#'
                i += 1
            else:
                note = ch.upper()
            i += 1
            octave = default_octave
            if i < len(block) and block[i].isdigit():
                octave = int(block[i])
                i += 1
            all_notes.append(f"{note}{octave}")
    return all_notes

def build_audio_from_notes(note_list, note_map, duration_ms=200):
    combined = AudioSegment.silent(duration=0)
    for note in note_list:
        fragment = note_map.get(note.upper())
        if fragment:
            audio = AudioSegment.from_wav(fragment)
            combined += audio[:duration_ms]
        else:
            print(f"Let op: fragment voor {note} niet gevonden")
            combined += AudioSegment.silent(duration=duration_ms)
    return combined

fragment_dir = "fragments"
pattern = """
g3 c4 e4 c4
g3 c4 e4 c4
g3 b3 d4 b3
g3 b3 d4 b3
a3 d4 f4 d4
a3 d4 f4 d4
a3 c4 e4 c4
a3 c4 e4 c4
"""
# gcec gcec gbdb gbdb adfd adf3d acec acec
# gcec gcec gbdb gbdb adfd adf3d acec acec
# gcec gcec gbdb gbdb adfd adf3d acec acec


note_map = build_note_fragment_map(fragment_dir)
notes = parse_note_string(pattern)
output = build_audio_from_notes(notes, note_map)
output.export("arpeggio_octaved.wav", format="wav")

from pydub import AudioSegment, silence
import parselmouth
import numpy as np
import os

# def detect_pitch(path):
#     snd = parselmouth.Sound(path)
#     pitch = snd.to_pitch()
#     values = pitch.selected_array['frequency']
#     values = values[values > 0]
#     return np.median(values) if len(values) > 0 else 0
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
    pitch = snd.to_pitch(time_step=0.01, pitch_floor=50, pitch_ceiling=15000)
    values = pitch.selected_array['frequency']
    values = values[values > 0]
    return np.median(values) if len(values) > 0 else 0


def split_on_silence(input_wav, output_dir, min_silence_len=100, silence_thresh=-40):
    os.makedirs(output_dir, exist_ok=True)
    audio = AudioSegment.from_wav(input_wav)
    chunks = silence.split_on_silence(audio,
                                      min_silence_len=min_silence_len,
                                      silence_thresh=silence_thresh)
    paths = []
    for i, chunk in enumerate(chunks):
        path = os.path.join(output_dir, f"fragment_{i}.wav")
        chunk.export(path, format="wav")
        paths.append(path)
    return paths

input_wav = "sweep-400-to-step-1.wav"
output_dir = "fragments-400-to-step-1"

fragments = split_on_silence(input_wav, output_dir)

pitches = []
for frag in fragments:
    hz = detect_pitch(frag)
    pitches.append(hz)

for i, pitch in enumerate(pitches):
    note = hz_to_note(pitch)
    print(f"Fragment {i}: {pitch:.2f} Hz -> {note}")

# for i, pitch in enumerate(pitches):
#     print(f"Fragment {i}: {pitch:.2f} Hz")



# import os
# import parselmouth
# import numpy as np
# from scipy.io import wavfile

# def detect_pitch(fragment):
#     snd = parselmouth.Sound(fragment)
#     pitch = snd.to_pitch()
#     pitch_values = pitch.selected_array['frequency']
#     pitch_values = pitch_values[pitch_values > 0]
#     if len(pitch_values) == 0:
#         return 0
#     return np.median(pitch_values)

# def split_audio(input_path, output_dir, duration):
#     import soundfile as sf
#     snd, sr = sf.read(input_path)
#     total_samples = len(snd)
#     samples_per_fragment = int(sr * duration)
#     os.makedirs(output_dir, exist_ok=True)
#     fragments = []
#     for i in range(0, total_samples, samples_per_fragment):
#         end = i + samples_per_fragment
#         if end > total_samples:
#             break
#         fragment = snd[i:end]
#         fragment_path = os.path.join(output_dir, f"fragment_{i//samples_per_fragment}.wav")
#         sf.write(fragment_path, fragment, sr)
#         fragments.append(fragment_path)
#     return fragments

# input_wav = "sweep2.wav"
# fragment_dir = "fragments"
# fragment_duration = 1.0

# fragments = split_audio(input_wav, fragment_dir, fragment_duration)

# pitches = []
# for frag in fragments:
#     hz = detect_pitch(frag)
#     pitches.append(hz)

# for i, pitch in enumerate(pitches):
#     print(f"Fragment {i}: {pitch:.2f} Hz")

import wave
import numpy as np
import sys

if len(sys.argv)<3:
    print("Usage: python pwm.py INPUT OUTPUT")
    sys.exit()
    
input_path = sys.argv[1] #"data/drums-resampled8kto44k-16b.wav"
output_path = sys.argv[2] #"data/pwm_output.wav"

group_size = 5  # aantal samples per blok

# WAV lezen
with wave.open(input_path, "rb") as wav:
    params = wav.getparams()
    frames = wav.readframes(params.nframes)
    signal = np.frombuffer(frames, dtype=np.int16).astype(np.float32)

# Normaliseren naar 0–1
signal = (signal - signal.min()) / (signal.max() - signal.min())

# PWM genereren
pwm_signal = []
for i in range(0, len(signal), group_size):
    block = signal[i:i+group_size]
    if len(block) < group_size:
        break
    avg = block[0]  # of np.mean(block) als je liever het gemiddelde neemt
    # ones = int(round(avg * group_size))
    ones = int(avg * group_size)
    pwm_block = [1.0]*ones + [0.0]*(group_size - ones)
    pwm_signal.extend(pwm_block)

# Schalen naar 16-bit int
pwm_int = (np.array(pwm_signal) * 32767).astype(np.int16)

# WAV schrijven
with wave.open(output_path, "wb") as outwav:
    outwav.setnchannels(1)
    outwav.setsampwidth(2)
    outwav.setframerate(44100)
    outwav.writeframes(pwm_int.tobytes())

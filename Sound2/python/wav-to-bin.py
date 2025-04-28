import numpy as np
import scipy.io.wavfile as wav
from scipy.signal import find_peaks
import struct
import os

# 🎵 Configuratie
BIN_FILE = "notes.bin"    # Uitvoer binair bestand
WAV_FILE = "music.wav"    # Invoer WAV-bestand
SEGMENT_DURATION = 0.001  #  ms per toonhoogte (segmentgrootte)
MIN_FREQ = 117            # Min frequentie (ongeveer 5000)
MAX_FREQ = 11000          # Max frequentie (ongeveer 4)
MIN_VALUE = 5000          # Minimum waarde in jouw systeem
MAX_VALUE = 4             # Maximum waarde in jouw systeem

# 📥 Lees het WAV-bestand in
samplerate, data = wav.read(WAV_FILE)

# Zet naar mono als het stereo is
if len(data.shape) > 1:
    data = data[:, 0]

# Bereken het aantal samples per segment
samples_per_segment = int(samplerate * SEGMENT_DURATION)

# 🎼 Functie om de dominante frequentie te bepalen
def dominante_frequentie(samples, samplerate):
    N = len(samples)
    fft_result = np.fft.fft(samples)
    frequencies = np.fft.fftfreq(N, d=1/samplerate)
    
    # Neem alleen het positieve spectrum
    fft_magnitude = np.abs(fft_result[:N//2])
    frequencies = frequencies[:N//2]

    # Zoek de piekfrequentie
    peak_indices, _ = find_peaks(fft_magnitude, height=np.max(fft_magnitude) * 0.2)
    if len(peak_indices) == 0:
        return MIN_FREQ  # Geen piek gevonden, zet op minimale frequentie

    peak_freq = frequencies[peak_indices[0]]
    return peak_freq

# 🔄 Converteer elke 5 ms naar een frequentiewaarde
output_values = []
for i in range(0, len(data), samples_per_segment):
    segment = data[i:i+samples_per_segment]
    
    # Voorkom te korte segmenten
    if len(segment) < samples_per_segment:
        break

    freq = dominante_frequentie(segment, samplerate)
    

    # 🔢 Converteer frequentie naar logaritmische schaal
    # scaled_value = int(
    #     MIN_VALUE + (MAX_VALUE - MIN_VALUE) * (np.log(freq / MIN_FREQ) / np.log(MAX_FREQ / MIN_FREQ))
    # )

    # print(freq)
    
    # scaled_value = max(4, min(5000, scaled_value))  # Beperk binnen bereik


    output_values.append(int(freq))

# 📝 Schrijf naar binary bestand
with open(BIN_FILE, "wb") as f:
    for value in output_values:
        f.write(struct.pack("<H", value))  # 16-bit little-endian opslaan

print(f"✅ Conversie voltooid! {len(output_values)} frequenties opgeslagen in {BIN_FILE}.")

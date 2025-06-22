import numpy as np
import struct
import sounddevice as sd

# 📥 Configuratie
BIN_FILE = "notes.bin"  # Binaire frequentiegegevens
DURATION_PER_NOTE = 0.001  # 5 ms per toon
SAMPLERATE = 44100  # CD-kwaliteit

# 📖 Lees de binaire frequentiewaarden
with open(BIN_FILE, "rb") as f:
    data = f.read()

# Converteer 16-bit waarden (2 bytes per frequentie)
frequencies = [struct.unpack("<H", data[i:i+2])[0] for i in range(0, len(data), 2)]

# 🎵 Genereer het audiosignaal
audio_wave = np.array([], dtype=np.float32)

for freq in frequencies:
    t = np.linspace(0, DURATION_PER_NOTE, int(SAMPLERATE * DURATION_PER_NOTE), endpoint=False)
    wave = 0.5 * np.sin(2 * np.pi * freq * t)  # Sinusgolf met halve amplitude
    audio_wave = np.concatenate((audio_wave, wave))  # Voeg toe aan de audio buffer

# 🔊 Speel het af
print(f"🎶 Speelt {len(frequencies)} tonen af...")
sd.play(audio_wave, samplerate=SAMPLERATE)
sd.wait()  # Wacht tot het geluid klaar is
print("✅ Klaar!")

import struct
import numpy as np

# 📥 Configuratie
BIN_FILE = "wave.bin"
MIN_VALUE = 4       # Laagste waarde
MAX_VALUE = 5000    # Hoogste waarde
STEP = 1            # Stapgrootte per toename (kan aangepast worden)

# 🔄 Genereer oplopende en aflopende reeks
# values = list(range(MIN_VALUE, MAX_VALUE + 1, STEP))

# scaled_value = int(
#       MIN_VALUE + (MAX_VALUE - MIN_VALUE) * (np.log(freq / MIN_FREQ) / np.log(MAX_FREQ / MIN_FREQ))
#   )
values = []

for i in range(0,200):
  values.append(i)
for i in range(0,100):
  values.append(i*i)
for i in range(0,200):
  values.append(i)
for i in range(0,100):
  values.append(i*i)
for i in range(0,100):
  values.append(i*i)
for i in range(0,100):
  values.append(i*i)
for i in range(0,100):
  values.append(i*i)

print(values)

# 📝 Schrijf naar binary bestand
with open(BIN_FILE, "wb") as f:
    for value in values:
        f.write(struct.pack("<H", value))  # Opslaan als 16-bit little-endian

print(f"✅ Bestand '{BIN_FILE}' gegenereerd met {len(values)} waarden.")

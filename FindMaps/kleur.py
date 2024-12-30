from PIL import Image
import os
import math

def binary_to_png(input_file, output_file):
    with open(input_file, 'rb') as f:
        data = f.read()

    bits = []
    hues = []
    for byte in data:
        byte_hue = int(byte / 255 * 360)
        hues.extend([byte_hue] * 8)
        bits.extend([(byte >> (7 - i)) & 1 for i in range(8)])
    
    width = 8*10
    height = math.ceil(len(bits) / width)
    img = Image.new('HSV', (width, height), (0, 0, 0))
    pixels = img.load()

    for i, bit in enumerate(bits):
        x = i % width
        y = i // width
        if bit == 1:
            pixels[x, y] = (hues[i], 255, 255)
        else:
            pixels[x, y] = (0, 0, 0)
    
    img.convert('RGB').save(output_file, 'PNG')

input_file = 'bandit-without-code.exe'
output_file = 'output.png'

if os.path.exists(input_file):
    binary_to_png(input_file, output_file)
    print(f"PNG opgeslagen als {output_file}")
else:
    print(f"Bestand {input_file} niet gevonden.")

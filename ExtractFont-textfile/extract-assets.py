import os
from PIL import Image

input_binary_file = "bandit.exe"
output_text_file = "bandit.txt"
assets_dir = "assets_bin"
assets_2_dir = "assets_txt"
png_output_file = "font_assets.png"

# Zorg dat de assets-mappen bestaan
os.makedirs(assets_dir, exist_ok=True)
os.makedirs(assets_2_dir, exist_ok=True)

# Start offset en grootte van een font-asset
start_offset = 824 - 2*12
asset_size = 24
num_assets = 58
ascii_start = 32 

# Image parameters
image_width = num_assets * 12  # 82 characters * 12 pixels per character
image_height = 12  # Each character is 12 pixels high
char_width = 12  # Each character is 12 pixels wide
char_height = 12  # Each character is 12 pixels high

with open(input_binary_file, 'rb') as bin_file, \
     open(output_text_file, 'w') as text_file:

    # Lees de volledige binary als een string van bits
    binary_string = ''.join(format(byte, '08b') for byte in bin_file.read())

    # Schrijf binary data naar het tekstbestand
    for i in range(0, len(binary_string), 16):
        print(binary_string[i:i+16], file=text_file)

    # Ga naar de start offset voor de font-assets
    bin_file.seek(start_offset)

    # Lees de benodigde bytes voor 82 assets
    total_bytes = num_assets * asset_size
    remaining_data = bin_file.read(total_bytes)

    # Maak een nieuwe afbeelding
    img = Image.new('1', (image_width, image_height), color=1)  # Binary image (1-bit)

    # Deel de data in blokken van 24 bytes en schrijf elk blok naar een bestand
    for i in range(0, len(remaining_data), asset_size):
        asset = remaining_data[i:i + asset_size]
        if len(asset) < asset_size:
            break  # Stop als er minder dan 24 bytes over zijn

        # Schrijf de asset als bin-bestand
        filename_base = f"chr{ascii_start + (i // asset_size):02d}"

        asset_file = os.path.join(assets_dir, f"{filename_base}.bin")
        with open(asset_file, 'wb') as af:
            af.write(asset)

        # Schrijf de asset als tekstbestand met nullen en enen
        asset_text_file = os.path.join(assets_2_dir, f"{filename_base}.txt")
        with open(asset_text_file, 'w') as atf:
            asset_bits = ''.join(format(byte, '08b') for byte in asset)
            for j in range(0, len(asset_bits), 16):
                blocks = asset_bits[j:j+16].replace("0"," ").replace("1","█")
                atf.write(blocks + '\n')

        # Teken het karakter in de afbeelding
        char_index = i // asset_size
        for y in range(char_height):
            row = (asset[y * 2] << 8 | asset[y * 2 + 1]) >> 4  # Combine two bytes per row and shift to ignore the lowest 4 bits
            for x in range(char_width):
                pixel = (row >> (11 - x)) & 1  # Extract each bit as a pixel
                img.putpixel((char_index * char_width + x, y), pixel)

# Sla de afbeelding op
img.save(png_output_file)

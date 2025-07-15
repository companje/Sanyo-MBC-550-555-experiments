#!/usr/bin/env python3

import sys
import os
from PIL import Image

def save_sprite(img, filename):
    w, h = img.size
    img = img.convert("RGB")
    pixels = list(img.getdata())

    wd8 = w // 8
    hd4 = h // 4
    total_cells = wd8 * hd4
    bytes_data = bytearray(total_cells * 12)

    for cell_y in range(hd4):
        for cell_x in range(wd8):
            cell_index = (cell_y * wd8 + cell_x) * 12
            for color in range(3):
                for row in range(4):
                    byte = 0
                    for col in range(8):
                        x = cell_x * 8 + col
                        y = cell_y * 4 + row
                        r, g, b = pixels[y * w + x]
                        v = [r, g, b][color]
                        if v > 50:
                            byte |= 1 << (7 - col)
                    bytes_data[cell_index + color * 4 + row] = byte

    with open(filename, "wb") as f:
        f.write(bytes_data)

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 ./png2palette.py <input_files>")
        sys.exit(1)

    for input_filename in sys.argv[1:]:
        if not input_filename.lower().endswith(".png"):
            print(f"Skipping non-PNG file: {input_filename}")
            continue

        output_filename = os.path.splitext(input_filename)[0] + ".pal"
        try:
            img = Image.open(input_filename)
            save_sprite(img, output_filename)
            print(f"Converted {input_filename} to {output_filename}")
        except Exception as e:
            print(f"Error processing {input_filename}: {e}")

if __name__ == "__main__":
    main()

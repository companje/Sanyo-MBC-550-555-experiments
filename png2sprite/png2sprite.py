#!/Users/rick/.pyenv/shims/python3

import sys
import os
from PIL import Image

def save_sprite(img, filename):
    w, h = img.size
    img = img.convert("RGB")
    pixels = list(img.getdata())

    wh = w * h
    whd8 = wh // 8
    wd2 = w // 2
    wd8 = w // 8
    hd4 = h // 4

    print(f"width x height = {w} x {h}")

    bytes_data = bytearray(2 + 3 * whd8)
    bytes_data[0] = wd8  # cols
    bytes_data[1] = hd4  # rows

    print(f"cols x rows = {wd8} x {hd4}")

    for y in range(h):
        for x in range(w):
            bit = 128 >> (x % 8)
            j = y * w + x
            i = (y // 4) * wd2 + (y % 4) + (x // 8) * 4
            r, g, b = pixels[j]
            for c in range(3):
                cc = [r, g, b][c]
                if cc > 50:
                    bytes_data[c * whd8 + i + 2] |= bit

    with open(filename, "wb") as f:
        f.write(bytes_data)

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 ./png2sprite.py <input_files>")
        sys.exit(1)

    for input_filename in sys.argv[1:]:
        if not input_filename.lower().endswith(".png"):
            print(f"Skipping non-PNG file: {input_filename}")
            continue

        output_filename = os.path.splitext(input_filename)[0] + ".spr"
        try:
            img = Image.open(input_filename)
            save_sprite(img, output_filename)
            print(f"Converted {input_filename} to {output_filename}")
        except Exception as e:
            print(f"Error processing {input_filename}: {e}")

if __name__ == "__main__":
    main()

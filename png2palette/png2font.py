from PIL import Image
import sys
import os

def png_to_bin(input_path):
    img = Image.open(input_path).convert("RGB")
    width, height = img.size
    pixels = img.load()
    output_path = os.path.join(os.path.dirname(input_path), "output.bin")

    with open(output_path, "wb") as f:
        bit_buffer = 0
        bit_count = 0
        for y in range(height):
            for x in range(width):
                r, g, b = pixels[x, y]
                bit = 0 if (r, g, b) == (0, 0, 0) else 1
                bit_buffer = (bit_buffer << 1) | bit
                bit_count += 1
                if bit_count == 8:
                    f.write(bytes([bit_buffer]))
                    bit_buffer = 0
                    bit_count = 0
        if bit_count > 0:
            bit_buffer = bit_buffer << (8 - bit_count)
            f.write(bytes([bit_buffer]))

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Gebruik: python script.py input.png")
        sys.exit(1)
    png_to_bin(sys.argv[1])




# from PIL import Image
# import sys
# import os

# def png_to_bin(input_path):
#     img = Image.open(input_path).convert("RGB")
#     width, height = img.size

#     if width != 8 or height != 1024:
#         raise ValueError("Afbeelding moet 8x1024 pixels zijn")

#     pixels = img.load()
#     output_path = os.path.join(os.path.dirname(input_path), "output.bin")

#     with open(output_path, "wb") as f:
#         for y in range(height):
#             byte = 0
#             for x in range(8):
#                 r, g, b = pixels[x, y]
#                 bit = 0 if (r, g, b) == (0, 0, 0) else 1
#                 byte = (byte << 1) | bit
#             f.write(bytes([byte]))

# if __name__ == "__main__":
#     if len(sys.argv) < 2:
#         print("Gebruik: python script.py input.png")
#         sys.exit(1)
#     png_to_bin(sys.argv[1])

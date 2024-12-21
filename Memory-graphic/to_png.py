from PIL import Image

def binary_to_png(input_file, output_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    width = len(lines[0].strip())
    height = len(lines)

    img = Image.new('RGB', (width, height))

    for y, line in enumerate(lines):
        for x, char in enumerate(line.strip()):
            # img.putpixel((x, y), 0 if char == '0' else 1)
            red_offset = 983040/1024
            red_length = 100
            if red_offset<y<red_offset+red_length:
                tint = (255,0,0)
            else:
                tint = (255,255,255)

            green_offset = 245760/1024
            green_length = 100
            if green_offset<y<green_offset+green_length:
                tint = (0,255,0)
            else:
                tint = (255,255,255)

            if char == '0':
                img.putpixel((x, y), (0, 0, 0))
            elif char == '1':
                img.putpixel((x, y), tint)

    img.save(output_file, 'PNG')

input_file = 'memory.txt'
output_file = 'memory.png'
binary_to_png(input_file, output_file)

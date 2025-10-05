from PIL import Image
import math

w, h = 640, 200

def frame_pixel(x, y, t):
    nx = (x - w/2) / w
    ny = (y - h/2) / h
    s1 = math.sin(2*math.pi*(nx*12.7 + ny*3.1) + t*math.pi/2)
    s2 = math.sin(2*math.pi*(nx*5.3 - ny*9.1) + t*math.pi/3)
    r = math.hypot(nx*1.3 + 0.15, ny*1.8 - 0.1)
    s3 = math.sin(2*math.pi*(r*22.0) + t*math.pi/5)
    v = s1 + s2 + s3
    b = 255 if v > 0 else 0
    b ^= (((x ^ y ^ (t*37)) & 4) >> 2) * 255
    return b

for t in range(4):
    img = Image.new("L", (w, h))
    pixels = img.load()
    for y in range(h):
        for x in range(w):
            pixels[x, y] = frame_pixel(x, y, t)
    img.save(f"frame{t}.png")

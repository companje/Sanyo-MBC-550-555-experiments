import numpy as np
import random

def generate_fair_distribution(width, height):
    pixels = [(y, x) for y in range(height) for x in range(width)]
    selected = []

    # start met een random pixel
    first = random.choice(pixels)
    selected.append(first)
    pixels.remove(first)

    while len(selected) < width * height:
        best_pixel = None
        best_dist = -1
        for p in pixels:
            dist = min((p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2 for q in selected)
            if dist > best_dist:
                best_dist = dist
                best_pixel = p
        selected.append(best_pixel)
        pixels.remove(best_pixel)

    return selected

def generate_dither_patterns():
    w, h = 8, 4
    fill_order = generate_fair_distribution(w, h)
    patterns = []

    for level in range(0, w * h + 1):  # 0 tot 32
        bitmap = np.zeros((h, w), dtype=int)
        for i in range(level):
            y, x = fill_order[i]
            bitmap[y, x] = 1
        patterns.append(bitmap)

    return patterns

def print_patterns(patterns):
    for i, bitmap in enumerate(patterns):
        print(f"Color {i:2d}:")
        for row in bitmap:
            print("".join(['█' if b else ' ' for b in row]))
        print()

patterns = generate_dither_patterns()
print_patterns(patterns)

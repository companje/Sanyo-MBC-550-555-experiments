from math import gcd

width = 99
height = 50
total = width * height

valid_steps = [i for i in range(2, total) if gcd(i, total) == 1]

print(valid_steps)
# print(len(valid_steps))

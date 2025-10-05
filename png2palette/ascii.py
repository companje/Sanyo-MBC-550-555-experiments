import pyperclip

lines = []
for i in range(0, 255, 16):
    line = ""
    for j in range(16):
        code = i + j
        if code >= 255:
            break
        char = chr(code)
        # if code < 32 or (127 <= code < 160):
        #     display = '.'
        # else:
            # display = char
        line += f"{char}" #{code:3}:{display}  "
    lines.append(line)

result = "\n".join(lines)
pyperclip.copy(result)
print("ASCII tabel is naar je klembord gekopieerd.")

print(result)
class BinaryFileAnalyzer:
    def __init__(self, file_path):
        with open(file_path, 'rb') as f:
            self.data = f.read()

    def default_decoder(self, start=0, count=0):
        html = "<div class='default-decoder'>"
        for i in range(start, start + count):
            if i < len(self.data):
                html += f"<span>{self.data[i]:08b}</span> "
                if (i - start + 1) % 16 == 0:
                    html += "<br>"
        html += "</div>"
        return html

    def decode_bitmaps(self, offset, width, height):
        html = "<div class='bitmap'>"
        for y in range(height):
            html += "<div class='row'>"
            for x in range(width):
                index = offset + (y * width * 3) + (x * 3)
                if index + 2 < len(self.data):
                    r, g, b = self.data[index:index+3]
                    html += f"<span style='background-color: rgb({r},{g},{b})'></span>"
            html += "</div>"
        html += "</div>"
        return html

    def decode_font(self, offset, count):
        html = "<div class='fonts'>"
        for i in range(count):
            font_offset = offset + (i * 24)
            if font_offset + 24 <= len(self.data):
                html += "<div class='font'>"
                for line in range(12):
                    line_data = int.from_bytes(self.data[font_offset + line * 2:font_offset + line * 2 + 2], 'big')
                    html += f"<div>{line_data:016b}</div>"
                html += "</div>"
        html += "</div>"
        return html

    def show_strings(self, offset, count):
        html = "<div class='strings'>"
        string_data = self.data[offset:offset+count]
        html += f"<pre>{string_data.decode('ascii', errors='ignore')}</pre>"
        html += "</div>"
        return html

# Voorbeeld van gebruik:
analyzer = BinaryFileAnalyzer("bandit-without-code.exe")
html = "<html><body>"
html += analyzer.default_decoder(count=799)
html += analyzer.decode_font(800, 59)
html += analyzer.show_strings(0x7753, 984)
html += analyzer.decode_bitmap(3120, 64*192)

html += "</body></html>"

with open("output.html", "w") as f:
    f.write(html)

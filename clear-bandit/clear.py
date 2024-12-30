def process_binary_file(input_file, output_file):
    regions = [
      (0x0000, 0x0014),  #MZ header
      (0x0297, 0x0081),  #code
      (0x0338, 0x08A8),  #FONT
      (0x08D1, 0x0293),  #code
      (0x0C30, 0x3000),  #sprites: key till bandit
      (0x3C20, 0x002E),  #strings: 0+NCN@NLNONRNUNFNI01
      (0x3C4E, 0x1E00),  #sprites: donut till scorpion
      (0x627A, 0x0018),  #string 1234567890123456789012345
      (0x6CF0, 0x062F),  #strings
      (0x7393, 0x03BF),  #strings trees, cacti, the timegates ...
      (0x7753, 0x03D8),  #strings
      (0x7E0A, 0x0678),  #strings
      (0x84A1, 0x0477),  #code
      (0x8BBB, 0x048F),  #strings
      (0x90DB, 0x003F),  #code
      (0x914A, 0x1E4C),  #code
      (0xAF96, 0x0012)   #string?
    ]

    with open(input_file, 'rb') as infile:
        data = bytearray(infile.read())

    for offset, length in regions:
        data[offset:offset + length] = b'\x00' * length

    with open(output_file, 'wb') as outfile:
        outfile.write(data)

# Pas de bestandsnamen hieronder aan
input_file = "bandit.exe"
output_file = "output.bin"
process_binary_file(input_file, output_file)

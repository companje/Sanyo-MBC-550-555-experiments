input_binary_file = "output.bin"
output_text_file = "output.txt"

with open(input_binary_file, 'rb') as bin_file, \
     open(output_text_file, 'w') as text_file:
  
  binary_string = ''.join(format(byte, '08b') for byte in bin_file.read())
  

  offset = 0
  width = 20

  for i in range(0, len(binary_string), width):
    s = binary_string[i+offset:i+offset+width]

    if "1" in s:

      s = s.replace("0"," ").replace("1","█")

      print(s, file=text_file)
    



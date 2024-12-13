input_binary_file = "bandit-without-code.exe"
output_text_file = "bandit-without-code.txt"

with open(input_binary_file, 'rb') as bin_file, \
     open(output_text_file, 'w') as text_file:
  
  binary_string = ''.join(format(byte, '08b') for byte in bin_file.read())
  
  # binary_string = binary_string.replace("0"," ").replace("1","█")
  for i in range(0, len(binary_string), 16):
    print(binary_string[i:i+16], file=text_file)
    



import random

input_binary_file = "memory_dos_basic_demo.bin"
output_text_file = "memory.txt"

with open(input_binary_file, 'rb') as bin_file, \
     open(output_text_file, 'w') as text_file:
  
  binary_string = ''.join(format(byte, '08b') for byte in bin_file.read())
  
  # binary_string = binary_string.replace("0"," ").replace("1","█")
  width = 1024
  for i in range(0, len(binary_string), width):
    line = binary_string[i:i+width]
    if line=="0"*width and random.randint(0,100)>1: 
      continue

    print(line, file=text_file)
    



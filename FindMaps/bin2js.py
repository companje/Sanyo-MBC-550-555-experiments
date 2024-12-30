#!/Users/rick/.pyenv/shims/python

import sys

def binary_to_js_array(input_file, output_file):
    with open(input_file, "rb") as f:
        binary_data = f.read()
    
    js_array = ', '.join(f"0x{byte:02X}" for byte in binary_data)
    js_code = f"const binaryData = new Uint8Array([{js_array}]);"
    
    with open(output_file, "w") as f:
        f.write(js_code)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python binary_to_js_array.py <input_binary_file> <output_js_file>")
    else:
        binary_to_js_array(sys.argv[1], sys.argv[2])

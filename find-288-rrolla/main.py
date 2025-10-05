def test_magic_constants(max_input=65536, divisor=288):
    for shift in range(16, 33):
        for magic in range(0x8000, 0x10000):
            success = True
            for x in range(0, max_input, 1):
                if ((x * magic) >> shift) != x // divisor:
                    success = False
                    break
            if success:
                print(f"Found: magic=0x{magic:04X}, shift={shift}")
                return

test_magic_constants(65536, 288)

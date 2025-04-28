import numpy as np

def generate_ramp_up_cue(start_freq, end_freq, duration_sec, sample_rate):
    total_samples = int(duration_sec * sample_rate)
    cue = []
    phase = 0.0

    for i in range(total_samples // 8):  # elke byte stelt 8 samples voor
        t = i / (total_samples // 8)
        freq = start_freq + (end_freq - start_freq) * t
        samples_per_cycle = sample_rate / freq
        samples_per_half = samples_per_cycle / 2

        byte = 0
        for bit in range(8):
            if phase < samples_per_half:
                bit_value = 1
            else:
                bit_value = 0
            byte |= (bit_value << bit)
            phase += 1
            if phase >= samples_per_cycle:
                phase = 0
        cue.append(byte)

    return cue

def save_to_inc_file(cue, filename):
    with open(filename, "w") as f:
        f.write("sound: db ")
        f.write(",".join(str(byte) for byte in cue))
    print(f"Bestand opgeslagen als {filename}")

if __name__ == "__main__":
    cue = generate_ramp_up_cue(start_freq=100, end_freq=5000, duration_sec=1.0, sample_rate=8000)
    save_to_inc_file(cue, "8bit-ramp_up_sound.inc")

    cue = generate_ramp_up_cue(start_freq=5000, end_freq=100, duration_sec=1.0, sample_rate=8000)
    save_to_inc_file(cue, "8bit-ramp_down_sound.inc")

    cue = generate_ramp_up_cue(start_freq=1000, end_freq=1000, duration_sec=1.0, sample_rate=8000)
    save_to_inc_file(cue, "8bit-1khz.inc")







# import numpy as np

# def generate_ramp_up_cue(start_freq, end_freq, duration_sec, sample_rate):
#     total_samples = int(duration_sec * sample_rate)
#     cue = []
#     phase = 0.0

#     for i in range(total_samples // 8):  # elke byte stelt 8 samples voor
#         t = i / (total_samples // 8)
#         freq = start_freq + (end_freq - start_freq) * t
#         samples_per_cycle = sample_rate / freq
#         samples_per_half = samples_per_cycle / 2

#         byte = 0
#         for bit in range(8):
#             if phase < samples_per_half:
#                 bit_value = 1
#             else:
#                 bit_value = 0
#             byte |= (bit_value << bit)
#             phase += 1
#             if phase >= samples_per_cycle:
#                 phase = 0
#         cue.append(byte)

#     return cue

# def save_to_inc_file(cue, filename):
#     with open(filename, "w") as f:
#         f.write("sound: db ")
#         f.write(",".join(str(byte) for byte in cue))
#     print(f"Bestand opgeslagen als {filename}")

# if __name__ == "__main__":
#     cue = generate_ramp_up_cue(start_freq=100, end_freq=5000, duration_sec=1.0, sample_rate=8000)
#     save_to_inc_file(cue, "ramp_up_sound.inc")

#     cue = generate_ramp_up_cue(start_freq=5000, end_freq=100, duration_sec=1.0, sample_rate=8000)
#     save_to_inc_file(cue, "ramp_down_sound.inc")

#     cue = generate_ramp_up_cue(start_freq=1000, end_freq=1000, duration_sec=1.0, sample_rate=8000)
#     save_to_inc_file(cue, "1khz.inc")

####################################


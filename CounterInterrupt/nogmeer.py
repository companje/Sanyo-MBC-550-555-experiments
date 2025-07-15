import numpy as np
import scipy.io.wavfile as wavfile

def generate_square_wave_sound(filename, frequency, duration, samplerate, duty_cycle_func=None):
    """
    Genereert een mono WAV-bestand met een blokgolf en optionele duty cycle modulatie.
    Genereert ook bijbehorende nuldoorgangenbestanden.

    Args:
        filename (str): De naam van het uit te voeren WAV-bestand.
        frequency (int): De frequentie van de blokgolf in Hz.
        duration (int): De totale duur van het geluid in seconden.
        samplerate (int): De samplefrequentie van het WAV-bestand in Hz.
        duty_cycle_func (callable, optional): Een functie die de duty cycle (0.0-0.5)
                                              retourneert voor een gegeven tijd (seconde).
                                              Indien None, wordt een vaste 0.5 duty cycle gebruikt.
    """
    num_samples = int(samplerate * duration)
    time = np.linspace(0, duration, num_samples, endpoint=False)
    audio = np.zeros(num_samples, dtype=np.float32)
    period = 1 / frequency

    zerocrossings_sample_numbers = []
    previous_audio_value = 0.0

    for i in range(num_samples):
        current_time = time[i]
        
        if duty_cycle_func:
            duty_cycle = duty_cycle_func(current_time)
            duty_cycle = max(0.0, min(0.5, duty_cycle)) # Zorg voor geldige grenzen
        else:
            duty_cycle = 0.5 # Standaard blokgolf

        phase = (current_time % period) / period

        if phase < duty_cycle:
            current_audio_value = 1.0
        else:
            current_audio_value = 0.0
        
        audio[i] = current_audio_value

        # Detecteer nuldoorgangen
        if current_audio_value != previous_audio_value:
            zerocrossings_sample_numbers.append(i)
        
        previous_audio_value = current_audio_value
    
    # --- WAV-bestand schrijven ---
    wavfile.write(filename, samplerate, audio)
    print(f"'{filename}' gegenereerd.")

    # --- Tekstbestand met samplenummers van nuldoorgangen schrijven ---
    zerocrossing_text_filename = filename.replace(".wav", "_samples.txt")
    with open(zerocrossing_text_filename, 'w') as f:
        f.write(f"Samplenummer\n")
        f.write(f"----------------\n")
        for sample_num in zerocrossings_sample_numbers:
            f.write(f"{sample_num}\n")
    print(f"'{zerocrossing_text_filename}' gegenereerd.")

    # --- Binair bestand met 32-bit samplenummers van nuldoorgangen schrijven ---
    zerocrossing_32bit_binary_filename = filename.replace(".wav", "_samples_32bit.bin")
    
    zerocrossings_32bit_data = np.array(zerocrossings_sample_numbers, dtype=np.uint32)
    
    with open(zerocrossing_32bit_binary_filename, 'wb') as f:
        f.write(zerocrossings_32bit_data.tobytes())
    
    print(f"'{zerocrossing_32bit_binary_filename}' gegenereerd. Samplenummers zijn opgeslagen als 32-bit unsigned integers.")


# --- Gemeenschappelijke Parameters ---
BASE_SAMPLERATE = 44100
BASE_DURATION = 3 # Seconden (voor demo geluiden, tenzij anders gespecificeerd)

# --- Geluid 6: Snelle Wobble Bass ---
# Een snelle LFO op de duty cycle om een 'wobble' of 'dubstep' achtig effect te krijgen.
def wobble_bass_func(t):
    return 0.25 + 0.25 * np.sin(2 * np.pi * 5 * t) # Snelle oscillatie van duty cycle
generate_square_wave_sound("6_wobble_bass_44k.wav", frequency=80, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE, duty_cycle_func=wobble_bass_func)

# --- Geluid 7: Glitchy Arpeggio (door snelle, onregelmatige modulatie) ---
# De duty cycle wordt snel en onregelmatig aangepast, wat een "glitchy" of "broken" arpeggio-achtig geluid creëert.
def glitchy_arpeggio_func(t):
    # Springt tussen verschillende duty cycles op basis van tijdsegmenten
    segment_duration = 0.1
    segment_index = int(t / segment_duration)
    
    if segment_index % 4 == 0:
        return 0.1 # Smal
    elif segment_index % 4 == 1:
        return 0.4 # Breed
    elif segment_index % 4 == 2:
        return 0.2 # Medium
    else:
        return 0.3 # Iets breder
generate_square_wave_sound("7_glitchy_arpeggio_44k.wav", frequency=330, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE, duty_cycle_func=glitchy_arpeggio_func)

# --- Geluid 8: Zachte Puls (zeer lage duty cycle) ---
# Een blokgolf met een zeer smalle pulsbreedte, wat een dunner, scherper of zelfs klikkend geluid kan geven.
def soft_pulse_func(t):
    # Zeer kleine duty cycle, variërend lichtjes
    return 0.01 + 0.005 * np.sin(2 * np.pi * 0.2 * t)
generate_square_wave_sound("8_soft_pulse_44k.wav", frequency=440, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE, duty_cycle_func=soft_pulse_func)

print("\nAlle geluiden zijn gegenereerd!")
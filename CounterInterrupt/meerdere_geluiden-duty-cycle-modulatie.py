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
    
    # Gebruik np.uint32 voor de samplenummers, aangezien deze de 16-bit limiet kunnen overschrijden.
    zerocrossings_32bit_data = np.array(zerocrossings_sample_numbers, dtype=np.uint32)
    
    with open(zerocrossing_32bit_binary_filename, 'wb') as f:
        f.write(zerocrossings_32bit_data.tobytes())
    
    print(f"'{zerocrossing_32bit_binary_filename}' gegenereerd. Samplenummers zijn opgeslagen als 32-bit unsigned integers.")


# --- Gemeenschappelijke Parameters ---
BASE_SAMPLERATE = 44100
BASE_DURATION = 3 # Seconden (voor demo geluiden, tenzij anders gespecificeerd)

# --- Geluid 1: Pure Blokgolf ---
# Een klassieke, volle blokgolf.
generate_square_wave_sound("1_pure_blokgolf_44k.wav", frequency=220, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE)

# --- Geluid 2: Pulserende Pad (langzame PWM) ---
# Duty cycle moduleert langzaam op en neer, voor een "golvend" of "phaser"-achtig effect.
def slow_pwm_func(t):
    return 0.25 + 0.25 * np.sin(2 * np.pi * 0.5 * t) # Moduleert tussen 0% en 50%
generate_square_wave_sound("2_pulserende_pad_44k.wav", frequency=220, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE, duty_cycle_func=slow_pwm_func)

# --- Geluid 3: Gated Bas (snelle aan/uit schakeling) ---
# Simuleert een kort, percussief geluid door de duty cycle snel te schakelen.
def gated_bas_func(t):
    gate_interval = 0.2 # Elke 0.2 seconden een "puls"
    if (t % gate_interval) < (gate_interval / 4): # Kwart van het interval aan
        return 0.5
    else:
        return 0.0
generate_square_wave_sound("3_gated_bas_44k.wav", frequency=110, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE, duty_cycle_func=gated_bas_func)

# --- Geluid 4: Riser/Sweeper (duty cycle verandert geleidelijk) ---
# De duty cycle verandert van smal naar breed (of andersom) gedurende de duur van het geluid,
# wat een oplopend of dalend "sweep" geluid geeft.
def riser_func(t):
    # Gaat van 0.05 (smalle puls) naar 0.45 (brede puls) over de duur van het fragment
    return 0.05 + 0.4 * (t / BASE_DURATION)
generate_square_wave_sound("4_riser_44k.wav", frequency=440, duration=BASE_DURATION, samplerate=BASE_SAMPLERATE, duty_cycle_func=riser_func)

# --- Geluid 5: Digitale Bel (met snelle amplitude-achtige modulatie) ---
# Creëert een bel-achtig geluid door de duty cycle kortstondig te moduleren na de aanval.
def digital_bell_func(t):
    if t < 0.1: # Snelle aanval
        return 0.5
    elif t < 0.5: # Kortstondige, snelle modulatie voor 'bel' effect
        return 0.25 + 0.25 * np.sin(2 * np.pi * 20 * t) # Snelle oscillatie
    else:
        return 0.0 # Val weg
generate_square_wave_sound("5_digitale_bel_44k.wav", frequency=880, duration=1.0, samplerate=BASE_SAMPLERATE, duty_cycle_func=digital_bell_func) # Kortere duur voor bel


print("\nAlle geluiden zijn gegenereerd!")
import numpy as np
import scipy.io.wavfile as wavfile

def create_stereo_fading_square_wave_wav(filename="blokgolf_stereo_faded.wav", frequency=220, duration=3, samplerate=8000, fade_duration=1):
    """
    Genereert een stereo WAV-bestand:
    - Linkerkanaal: Blokgolf met duty cycle fade-in en fade-out.
    - Rechterkanaal: Pure blokgolf (constante 50% duty cycle).
    Schrijft ook binaire bestanden (0/1 en 16-bit samplenummers van het linkerkanaal)
    en een tekstbestand met samplenummers van nuldoorgangen (linkerkanaal).

    Args:
        filename (str): De naam van het uit te voeren WAV-bestand.
        frequency (int): De frequentie van de blokgolf in Hz.
        duration (int): De totale duur van het geluid in seconden.
        samplerate (int): De samplefrequentie van het WAV-bestand in Hz.
        fade_duration (int): De duur van de duty cycle fade-in en fade-out in seconden.
    """

    num_samples = int(samplerate * duration)
    
    # Controleer of het aantal samples binnen uint16 past (max 65535)
    if num_samples > 65535:
        print(f"WAARSCHUWING: Het berekende aantal samples ({num_samples}) overschrijdt de maximale waarde van een 16-bit unsigned integer (65535).")
        print("De 16-bit binaire output kan incorrecte waarden bevatten.")
    
    time = np.linspace(0, duration, num_samples, endpoint=False)
    
    # Maak een 2D array voor stereo audio: [num_samples, 2]
    # Kolom 0 is links, Kolom 1 is rechts
    audio_stereo = np.zeros((num_samples, 2), dtype=np.float32)
    
    zerocrossings_binary_01 = np.zeros(num_samples, dtype=np.int8) 
    zerocrossings_sample_numbers = [] 

    period = 1 / frequency
    previous_left_channel_value = 0.0 # Houd de vorige waarde van het linkerkanaal bij voor nuldoorgangen

    # Bereken het startpunt voor de fade-out in tijd
    fade_out_start_time = duration - fade_duration
    if fade_out_start_time < 0:
        fade_out_start_time = 0

    for i in range(num_samples):
        current_time = time[i]
        
        # --- Berekening voor Linkerkanaal (met fades) ---
        duty_cycle_left = 0.5 # Standaard 50% duty cycle voor links

        # Fade-in (eerste 'fade_duration' seconden)
        if current_time < fade_duration:
            duty_cycle_left = 0.5 * (current_time / fade_duration)
        # Fade-out (vanaf 'fade_out_start_time' tot het einde van de 'duration')
        elif current_time >= fade_out_start_time:
            time_in_fade_out = current_time - fade_out_start_time
            duty_cycle_left = 0.5 * (1 - (time_in_fade_out / fade_duration))
        
        # Zorg ervoor dat duty_cycle_left binnen de grenzen blijft
        duty_cycle_left = max(0.0, duty_cycle_left) 
        duty_cycle_left = min(0.5, duty_cycle_left)

        # Genereer de blokgolf voor het linkerkanaal
        phase = (current_time % period) / period
        if phase < duty_cycle_left:
            current_left_channel_value = 1.0
        else:
            current_left_channel_value = 0.0
        
        audio_stereo[i, 0] = current_left_channel_value # Linkerkanaal

        # --- Berekening voor Rechterkanaal (pure blokgolf zonder fades) ---
        # De duty cycle is constant 0.5 (perfecte blokgolf)
        duty_cycle_right = 0.5 
        if phase < duty_cycle_right:
            current_right_channel_value = 1.0
        else:
            current_right_channel_value = 0.0
        
        audio_stereo[i, 1] = current_right_channel_value # Rechterkanaal

        # --- Nuldoorgangen detecteren (alleen voor Linkerkanaal) ---
        if current_left_channel_value != previous_left_channel_value:
            zerocrossings_binary_01[i] = 1
            zerocrossings_sample_numbers.append(i)
        
        previous_left_channel_value = current_left_channel_value

    # --- WAV-bestand schrijven ---
    # wavfile.write kan een 2D array aan voor stereo
    wavfile.write(filename, samplerate, audio_stereo)
    print(f"Stereo WAV-bestand '{filename}' (duur: {duration}s) is succesvol aangemaakt.")

    # --- Binair bestand met 0/1 nuldoorgangen (van linkerkanaal) schrijven ---
    zerocrossing_binary_01_filename = filename.replace(".wav", "_zerocrossings_01.bin")
    with open(zerocrossing_binary_01_filename, 'wb') as f:
        f.write(zerocrossings_binary_01.tobytes())
    print(f"Binair bestand met 0/1 nuldoorgangen (linkerkanaal) '{zerocrossing_binary_01_filename}' is succesvol aangemaakt.")

    # --- Tekstbestand met samplenummers van nuldoorgangen (van linkerkanaal) schrijven ---
    zerocrossing_text_filename = filename.replace(".wav", "_zerocrossings_samples.txt")
    with open(zerocrossing_text_filename, 'w') as f:
        f.write(f"Samplenummer (Linkerkanaal)\n")
        f.write(f"---------------------------\n")
        for sample_num in zerocrossings_sample_numbers:
            f.write(f"{sample_num}\n")
    print(f"Tekstbestand met samplenummers van nuldoorgangen (linkerkanaal) '{zerocrossing_text_filename}' is succesvol aangemaakt.")

    # --- Binair bestand met 16-bit samplenummers van nuldoorgangen (van linkerkanaal) schrijven ---
    zerocrossing_16bit_binary_filename = filename.replace(".wav", "_zerocrossings_16bit_fit.bin")
    
    zerocrossings_16bit_data = np.array(zerocrossings_sample_numbers, dtype=np.uint16)
    
    with open(zerocrossing_16bit_binary_filename, 'wb') as f:
        f.write(zerocrossings_16bit_data.tobytes())
    
    print(f"Binair bestand met 16-bit samplenummers (linkerkanaal) '{zerocrossing_16bit_binary_filename}' is succesvol aangemaakt.")
    print(f"Alle samplenummers ({len(zerocrossings_sample_numbers)} in totaal) passen nu correct in 16-bit unsigned integers.")


# Roep de functie aan om de bestanden te maken
if __name__ == "__main__":
    create_stereo_fading_square_wave_wav()
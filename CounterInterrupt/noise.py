import numpy as np
import scipy.io.wavfile as wavfile

def generate_noise_like_square_wave_duty_cycle_fade(filename="digital_noise_duty_cycle_fade_in.wav", frequency=1000, duration=3, samplerate=44100, fade_in_duration=2):
    """
    Genereert een mono WAV-bestand met een blokgolf die op ruis lijkt,
    waarbij de fade-in uitsluitend wordt geregeld via duty cycle modulatie.

    Args:
        filename (str): De naam van het uit te voeren WAV-bestand.
        frequency (int): De basis frequentie van de blokgolf in Hz.
        duration (int): De totale duur van het geluid in seconden.
        samplerate (int): De samplefrequentie van het WAV-bestand in Hz.
        fade_in_duration (int): De duur van de fade-in in seconden.
    """
    num_samples = int(samplerate * duration)
    time = np.linspace(0, duration, num_samples, endpoint=False)
    audio = np.zeros(num_samples, dtype=np.float32)
    period = 1 / frequency

    # Beginwaarde voor duty cycle (zal toenemen tijdens fade-in en daarna fluctueren)
    current_duty_cycle = 0.001 # Start zeer laag voor een bijna stille begin
    
    # Bepaal het aantal samples voor de fade-in
    fade_in_samples = int(samplerate * fade_in_duration)
    if fade_in_samples > num_samples:
        fade_in_samples = num_samples

    # De maximale duty cycle voor de ruis, hier 0.25, zodat er nog ruimte is om te fluctueren
    # en het niet een 50% blokgolf wordt. Experimenteer hiermee!
    max_noise_duty_cycle = 0.25 

    for i in range(num_samples):
        current_time = time[i]
        
        # --- Duty Cycle Fade-in Logica ---
        target_duty_cycle_for_noise = max_noise_duty_cycle
        if i < fade_in_samples:
            # Geleidelijke toename van de duty cycle van bijna 0 naar max_noise_duty_cycle
            # Dit is de 'fade' door de duty cycle aan te passen
            current_duty_cycle_for_fade = 0.001 + (max_noise_duty_cycle - 0.001) * (i / fade_in_samples)
        else:
            current_duty_cycle_for_fade = max_noise_duty_cycle # Volle duty cycle na de fade-in


        # --- Willekeurige Modulatie voor Ruis-effect ---
        # Voeg de willekeurige fluctuatie toe Bovenop de huidige fade-in duty cycle
        modulated_duty_cycle = current_duty_cycle_for_fade + np.random.uniform(-0.05, 0.05) 
        
        # Houd de totale duty cycle binnen werkbare grenzen (bijv. 0.001 tot 0.49)
        # We voorkomen hiermee clipping en zorgen dat de golf altijd een signaal geeft
        modulated_duty_cycle = max(0.001, min(0.49, modulated_duty_cycle))

        # Bereken de fase van de blokgolf
        phase = (current_time % period) / period

        # Genereer de blokgolf met de gemoduleerde duty cycle
        if phase < modulated_duty_cycle:
            audio[i] = 1.0 # Amplitude blijft 1.0 of 0.0
        else:
            audio[i] = 0.0
    
    # Schrijf het geluid naar een WAV-bestand
    wavfile.write(filename, samplerate, audio)
    print(f"Digitaal ruisbestand '{filename}' (duur: {duration}s, fade-in via duty cycle: {fade_in_duration}s) is succesvol aangemaakt.")

# Roep de functie aan om het bestand te maken
if __name__ == "__main__":
    generate_noise_like_square_wave_duty_cycle_fade(frequency=1000, duration=3, samplerate=44100, fade_in_duration=3)
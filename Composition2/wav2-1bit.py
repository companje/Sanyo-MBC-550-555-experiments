import numpy as np
import wave
from scipy.signal import resample
import sounddevice as sd
from scipy.signal import butter, lfilter

def wav_to_1bit(audio, samplerate=8000):
    audio = audio.astype(np.float32)
    audio /= np.max(np.abs(audio))
    
    err = 0.0
    bits = []
    for sample in audio:
        val = sample + err
        bit = 1 if val >= 0 else 0
        quantized = 1.0 if bit else -1.0
        err = val - quantized
        bits.append(bit)
    return np.array(bits, dtype=np.uint8)

def load_and_resample_wav(wavfile, target_samplerate=8000):
    with wave.open(wavfile, 'rb') as wf:
        n_channels = wf.getnchannels()
        framerate = wf.getframerate()
        n_frames = wf.getnframes()
        raw_data = wf.readframes(n_frames)

    audio = np.frombuffer(raw_data, dtype=np.int16)
    if n_channels > 1:
        audio = audio.reshape(-1, n_channels).mean(axis=1)

    if framerate != target_samplerate:
        num_samples = int(len(audio) * target_samplerate / framerate)
        audio = resample(audio, num_samples)
    return audio.astype(np.float32), target_samplerate

# def bitstream_to_audio(bits, samplerate):
#     audio = (bits * 2 - 1).astype(np.float32) * 0.3
#     return audio


def bitstream_to_audio(bits, samplerate):
    audio = (bits * 2 - 1).astype(np.float32)
    audio *= 0.05  # veel zachter

    b, a = butter(6, 2000 / (samplerate / 2), btype='low')
    filtered = lfilter(b, a, audio)
    return filtered

def save_bitstream(bits, filename):
    bit_bytes = np.packbits(bits)
    with open(filename, 'wb') as f:
        f.write(bit_bytes)

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description="Convert WAV to 1-bit audio, preview sound, and export BIN.")
    parser.add_argument("input", help="Input WAV file")
    parser.add_argument("--output", help="Output BIN file", default=None)
    parser.add_argument("--rate", type=int, default=8000, help="Target sample rate (default: 8000)")
    args = parser.parse_args()

    audio, samplerate = load_and_resample_wav(args.input, args.rate)
    bits = wav_to_1bit(audio, samplerate)

    print("🔊 Speelt 1-bit audio preview af...")
    audio_out = bitstream_to_audio(bits, samplerate)
    sd.play(audio_out, samplerate)
    sd.wait()

    if args.output:
        save_bitstream(bits, args.output)
        print(f"✅ Bitstream opgeslagen naar: {args.output}")

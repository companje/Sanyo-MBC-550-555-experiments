import pyaudio

sample_rate = 8000
file_path = 'data/drums.raw'

with open(file_path, 'rb') as f:
    audio_data = f.read()

p = pyaudio.PyAudio()
stream = p.open(format=pyaudio.paUInt8,
                channels=1,
                rate=sample_rate,
                output=True)

stream.write(audio_data)
stream.stop_stream()
stream.close()
p.terminate()

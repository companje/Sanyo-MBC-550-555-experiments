#!/bin/bash

# for file in wav/*.wav; do
#     filename=$(basename "$file" .wav)
#     python wav2bin.py "wav/$filename.wav" "bin/$filename.bin"
# done

python wav2bin.py "wav/b37-choir-F5.wav" "bin/b37-choir-F5.bin" .06
python wav2bin.py "wav/b37-choir-C5.wav" "bin/b37-choir-C5.bin" .06
python wav2bin.py "wav/b37-choir-Es5.wav" "bin/b37-choir-Es5.bin" .06
python wav2bin.py "wav/b37-choir-A5.wav" "bin/b37-choir-A5.bin" .06
python wav2bin.py "wav/pluck.wav" "bin/pluck.bin" .06
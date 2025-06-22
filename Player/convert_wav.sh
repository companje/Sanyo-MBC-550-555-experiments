base="${1%.*}"
python convert_wav.py $base.wav $base.inc  && python play.py $base.inc
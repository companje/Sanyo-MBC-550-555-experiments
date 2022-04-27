now=$(date +"%FT%H%M") # 2016-04-25T1030
input_pattern="frames/*.jpg"
output_filename="frames_$now.mp4"

ffmpeg -pattern_type glob -i "$input_pattern" -vcodec mpeg4 -y -q:v 0 $output_filename


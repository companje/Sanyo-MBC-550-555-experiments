while true
do
  name=vertical-gradient-20x8
  python3 /Users/rick/Sanyo-Experiments-repo/png2palette/png2font.py $name.png
  mv output.bin $name.bin
  cp $name.bin /Users/rick/Sanyo-Experiments-repo/CityInABottle/data/
  cp $name.bin /Users/rick/Sanyo-Experiments-repo/CityInABottle/data/
  sleep 4
done
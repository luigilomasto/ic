#!/bin/zsh

cd ~/Dati
for file in $(ls *.bmp);do
	octave --silent --eval "fromRGBtoValue(\"$file\", \"~/ic/color.bmp \")"
done 
cd -

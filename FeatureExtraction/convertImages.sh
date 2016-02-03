#!/bin/zsh

cd ~/Dati
for file in $(ls *_cleared.bmp);do
	string="fromRGBtoValue(\"$file\", \"~/ic/color.bmp\")"
	octave --silent --eval "$string"
done 
cd -

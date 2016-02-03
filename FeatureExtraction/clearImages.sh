#!/bin/zsh

cd ~/Dati
for file in $(ls *.bmp);do
	octave --silent --eval "clearImage(\"$file\")"
done 
cd -

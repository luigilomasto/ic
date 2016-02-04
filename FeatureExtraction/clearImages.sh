#!/bin/zsh

cd ~/Dati
for file in $(ls *.png);do
	octave --silent --eval "clearImage(\"$file\")"
done 
cd -

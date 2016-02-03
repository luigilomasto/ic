#!/bin/zsh

cd ~/DatiNew
for file in $(ls *.bmp);do
	octave --silent --eval "clearImage(\"$file\")"
done 
cd -

#!/bin/zsh

if [ -z "$1" ]; then
	startIndex=0
else
	startIndex=$1
fi

if [ -z "$2" ]; then
	endIndex=0
else
	endIndex=$1
fi

cd ~/Dati
for i in {$startIndex..$endIndex};do
	image=$i"_cleared.bmp"
	if [ -f $image ]; then
		string="fromRGBtoValue(\"$image\", \"~/ic/color.bmp\")"
		octave --silent --eval "$string"
	fi
done 
cd -

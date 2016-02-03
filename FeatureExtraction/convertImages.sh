#!/bin/zsh

if [ -z "$1" ]; then
	startIndex=0
else
	startIndex=$1
fi

if [ -z "$2" ]; then
	endIndex=322
else
	endIndex=$2
fi

cd ~/Dati
for (( i = $startIndex; i < $endIndex; i++ )); do
	image=$i"_cleared.bmp"
	if [ -f $image ]; then
		string="fromRGBtoValue(\"$image\", \"~/ic/color.bmp\")"
		octave --silent --eval "$string"
	fi
done 
cd -

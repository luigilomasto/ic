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
	image=$i"_cleared_bn_left.bmp"
	if [ -f $image ]; then
		string="rotateFeet(\"$image\", true)"
		octave --silent --eval "$string"
	fi
	image=$i"_cleared_bn_right.bmp"
	if [ -f $image ]; then
		string="rotateFeet(\"$image\", false)"
		octave --silent --eval "$string"
	fi
done 
cd -

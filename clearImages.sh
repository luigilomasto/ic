#!/bin/zsh

cd ~/Dati
for dir in $(ls -d */);do
	cd $dir
	if [ -d 'rec000000' ]; then
		cd rec000000
		octave --silent --eval 'clearImage("000.bmp")'
		cd ..
	fi
	cd ..
done 

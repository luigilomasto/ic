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
for (( i = $startIndex; i <= $endIndex; i++ )); do
	image=$i"_cleared_bn.png"
	if [ -f $image ]; then
		string="splitImages(\"$image\")"
		octave --silent --eval "$string"
	fi
done 
cd -

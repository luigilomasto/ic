if [ -z "$1" ]; then
	basePath='.'
else
	basePath=$1
fi

cd $basePath

for file in $(ls *.bmp);do
	filename=$(basename $file .bmp)
	newfilename=$filename".png"
	# echo $file" "$newfilename
	convert $file $newfilename
done

cd -

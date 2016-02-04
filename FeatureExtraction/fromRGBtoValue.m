function fromRGBtoValue(imagePath, colorImagePath)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
	pkg load parallel;
end
piedergb = im2double(imread(imagePath));
[x,y,z] = size(piedergb);
myMatrixColor = extractColor(colorImagePath);
[num_colors,rgb] = size(myMatrixColor);
piedeValue=zeros(x,y,'double');
if ~isOctave
	parfor i=1:x
	    for j=1:y
		    min = realmax;
		    minIndex = 0;
		    for k=1:num_colors
		      diff = sqrt(sum((squeeze(piedergb(i,j,:))'-myMatrixColor(k, 1:3)).^2));
		      if(diff < min)
		        minIndex = k;
		        min = diff;
		      end
		    end
		    piedeValue(i,j) = myMatrixColor(minIndex,4);
	    end
	end
else
	for i=1:x
	    for j=1:y
		    min = realmax;
		    minIndex = 0;
		    for k=1:num_colors
		      diff = sqrt(sum((squeeze(piedergb(i,j,:))'-myMatrixColor(k, 1:3)).^2));
		      if(diff < min)
		        minIndex = k;
		        min = diff;
		      end
		    end
		    piedeValue(i,j) = myMatrixColor(minIndex,4);
	    end
	end
end

newImagePath = strrep(imagePath, '.bmp', '');
newImagePath = strcat(newImagePath, '_bn.bmp');
imwrite(piedeValue, newImagePath);
end

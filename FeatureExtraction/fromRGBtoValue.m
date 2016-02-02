function piedeValue = fromRGBtoValue(imagePath)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
	pkg load parallel;
end
piedergb = im2double(imread(imagePath));
[x,y,z] = size(piedergb);
myMatrixColor = extractColor('../color.bmp');
[num_colors,rgb] = size(myMatrixColor);
piedeValue=zeros(x,y,'double');
tic
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

imwrite(piedeValue, 'piedeBN.bmp')
clear x; clear y; clear z; clear minIndex; clear min; clear diff; clear i;
clear j; clear k; clear num_colors; clear rgb; 
toc
end

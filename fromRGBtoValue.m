isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image
	pkg load parallel
end
piedergb = im2double(imread('000.bmp'));
[x,y,z] = size(piedergb);
[x1,y1] = size(myMatrixColor);
piedeImg=zeros(x,y,z);
piedeValue=zeros(x,y);
tic
if ~isOctave
	parfor i=1:x
	    for j=1:y
		min = realmax;
		minIndex = 0;
		for k=1:x1
		  diff = sqrt(sum((squeeze(piedergb(i,j,:))'-myMatrixColor(k, 1:3)).^2));
		  if(diff < min)
		    minIndex = k;
		    min = diff;
		  end
		end
		piedeImg(i,j,:) = myMatrixColor(minIndex, 1:3);
		piedeValue(i,j) = myMatrixColor(minIndex,4);
	    end
	end
else
	for i=1:x
	    for j=1:y
		min = realmax;
		minIndex = 0;
		for k=1:x1
		  diff = sqrt(sum((squeeze(piedergb(i,j,:))'-myMatrixColor(k, 1:3)).^2));
		  if(diff < min)
		    minIndex = k;
		    min = diff;
		  end
		end
		piedeImg(i,j,:) = myMatrixColor(minIndex, 1:3);
		piedeValue(i,j) = myMatrixColor(minIndex,4);
	    end
	end
end
clear x; clear y; clear z; clear minIndex; clear min; clear diff; clear i;
clear j; clear k; clear x1; clear y1;
toc

function clearImage(imagePath)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image
end

image = im2double(imread(imagePath));

[x,y,z] = size(image);
whiteCol = ones(x, z);

half = idivide(int32(y), 2, 'round');
middle_col = squeeze(image(:,half,:));

%barycenter crosses the middle of image
if ~isequal(whiteCol, middle_col)
	for j=half-1:-1:1
	    actualCol = squeeze(image(:,j,:));
	    if isequal(whiteCol, actualCol);
		break;
	    end
	end


	image(:,(j:half),:) = 1;

	for j=half+1:y
	    actualCol = squeeze(image(:,j,:));
	    if isequal(whiteCol, actualCol);
		break;
	    end
	end

	image(:,(half:j),:) = 1;
%barycenter does not cross center...left or right?
else
	%computing on the left
	for j=half-1:-1:1
	    actualCol = squeeze(image(:,j,:));
	    if isequal(whiteCol, actualCol);
		break;
	    end
	end

	%computing on the right
	for k=half+1:y
	    actualCol = squeeze(image(:,j,:));
	    if isequal(whiteCol, actualCol);
		break;
	    end
	end

	kdiff = abs(half - k);
	jdiff = abs(half - j);
	%barycenter on the left
	if(jdiff < kdiff)
		for i=j:-1:1
		    actualCol = squeeze(image(:,i,:));
		    if isequal(whiteCol, actualCol);
			break;
		    end
		end
		image(:, (i:j),:) = 1;
	%barycenter on the right
	else
		for i=k:y
		    actualCol = squeeze(image(:,i,:));
		    if isequal(whiteCol, actualCol);
			break;
		    end
		end
		image(:, (k:i),:) = 1;
	end
end

imwrite(image,imagePath);

end

function splitImages(imagePath)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
end
img = im2double(imread(imagePath));
[num_rows, num_cols] = size(img);
half = idivide(int32(num_cols), 2, 'round');
middle_col = img(:, half);
black_col = zeros(num_rows, 1);
if isequal(middle_col, black_col)
	for i=half:-1:1
		actual_col = img(:, i);
		if ~isequal(black_col, actual_col)
			leftBorder = i;
		end
	end
	for i=half:num_cols
		actual_col = img(:, i);
		if ~isequal(black_col, actual_col)
			rightBorder = i;
		end
	end

	splitCol = leftBorder + rightBorder;
	splitCol = idivide(int32(splitCol), 2, 'round');

	leftImage = img(:, 1:splitCol);
	rightImage = img(:, splitCol:num_cols);

	pathLeft = strrep(imagePath, '.bmp', '');
	pathLeft = strcat(pathLeft, '_left.bmp');
	pathRight = strrep(imagePath, '.bmp', '');
	pathRight = strcat(pathRight, '_right.bmp');
	imwrite(leftImage,pathLeft);
	imwrite(rightImage,pathRight);
end

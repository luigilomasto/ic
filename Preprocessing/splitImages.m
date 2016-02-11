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
			break;
		end
	end
	leftBorder = i;
	for i=half:num_cols
		actual_col = img(:, i);
		if ~isequal(black_col, actual_col)
			break;
		end
	end
    rightBorder = i;
	splitCol = leftBorder + rightBorder;
	splitCol = idivide(int32(splitCol), 2, 'round');

	leftImage = img(:, 1:splitCol);
	rightImage = img(:, splitCol:num_cols);

	pathLeft = strrep(imagePath, '.png', '');
	pathLeft = strcat(pathLeft, '_left.png');
	pathRight = strrep(imagePath, '.png', '');
	pathRight = strcat(pathRight, '_right.png');
	imwrite(leftImage,pathLeft);
	imwrite(rightImage,pathRight);
end

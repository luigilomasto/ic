function rotateFeet(imagePath, left)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
  pkg load mapping;
end
img = im2double(imread(imagePath));
[num_rows, num_cols] = size(img);
black_col = zeros(num_rows, 1);
black_row = zeros(1, num_cols);
if left
  index_begin = num_cols;
  index_end = 1;
  step = -1;
else
  index_begin = 1;
  index_end = num_cols;
  step = 1;
end
for col_start_piede=index_begin:step:index_end
  actual_col = img(:, col_start_piede);
  if ~isequal(actual_col, black_col)
    break;
  end
end

for row_start_piede=num_rows:-1:1
  actual_row = img(row_start_piede, :);
  if ~isequal(actual_row, black_row)
    break;
  end
end

[point1, point2] = centreOfMaxPressure(img);
x1 = point1(1);
y1 = point1(2);
x2 = point2(1);
y2 = point2(2);
x1 = num_rows - x1;
x2 = num_rows - x2;
angolar_coefficient = (y2-y1)/(x2-x1);
angle = atan(angolar_coefficient);
angle = rad2deg(angle); 

%if left
   % angle = -angle;
%end
rotated_image = rotateAround(img, row_start_piede, col_start_piede, angle);
pathRotatedImage= strrep(imagePath, '.bmp', '');
pathRotatedImage = strcat(pathRotatedImage, '_rotated.bmp');
imwrite(rotated_image, pathRotatedImage);
end

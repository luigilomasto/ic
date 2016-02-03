left = false;
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
end
img = im2double(imread('./315_cleared_bn_right.bmp'));
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

angle = 20;
if left
    angle = -angle;
end
rotated_image = rotateAround(img, row_start_piede, col_start_piede, angle);
imshow(img);
figure(2);
imshow(rotated_image);

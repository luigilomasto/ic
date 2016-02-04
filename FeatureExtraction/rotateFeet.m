function rotateFeet(imagePath, left)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
  pkg load mapping;
end
img = im2double(imread(imagePath));
[num_rows, num_cols] = size(img);

[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(img);

row_start_piede = lower_bound;
if left
  col_start_piede = right_bound;
else
  col_start_piede = left_bound;
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

%we can be quite generous with the amount of space since later we
%will crop the image
space = 400;

cols_to_add = zeros(num_rows, space);
rows_to_add = zeros(space, num_cols+space);

if left
  img = [img cols_to_add];
else
  img = [cols_to_add img];
end

img = [rows_to_add; img];

rotated_image = rotateAround(img, row_start_piede, col_start_piede, angle, 'bicubic');
%crop image here
%new boundaries must be found before crop
[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(img);
rotated_image = rotated_image(left_bound:right_bound, lower_bound:upper_bound);
%save image
pathRotatedImage= strrep(imagePath, '.png', '');
pathRotatedImage = strcat(pathRotatedImage, '_rotated.png');
imwrite(rotated_image, pathRotatedImage);
end

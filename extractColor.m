function myMatrixColor = extractColor(colorImagePath)
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image
end
imdata = imread(colorImagePath);
orig_color=squeeze(imdata(9,:,:));
[num_pixels, num_rgb] = size(orig_color);

white = [255,255,255];
myMatrixColor = zeros(40, 3, 'uint8');
myMatrixColor(1, :) = white;
last_pixel = white;
indice = 2;
for i=1:num_pixels
    test = last_pixel ~= orig_color(i,:);
    if test(1) == 1 | test(2) == 1 | test(3) ==1
        myMatrixColor(indice, :) = orig_color(i, :);
        last_pixel = orig_color(i, :);
        indice = indice + 1;
    end
end

[num_colors, num_rgb1] = size(myMatrixColor);

col_to_add = zeros(1, num_colors);
col_to_add(:,1) = 0;
col_to_add(:,2:num_colors) = linspace(0,1,num_colors-1);

myMatrixColor = im2double(myMatrixColor);
myMatrixColor = [myMatrixColor col_to_add'];

clear imdata; clear orig_color; clear num_pixels; clear num_rgb;
clear white; clear black; clear last_pixel; clear indice;
clear test; clear num_colors; clear num_rgb1; clear col_to_add;
clear i;
end

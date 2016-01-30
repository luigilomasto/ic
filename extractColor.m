isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image
end
imdata = imread('color.bmp');
orig_color=squeeze(imdata(9,:,:));
[num_pixels, num_rgb] = size(orig_color);

white = [255,255,255];
black = [0, 0 ,0];
myMatrixColor = zeros(41, 3, 'uint8');
myMatrixColor(1, :) = white;
myMatrixColor(2, :) = black;
last_pixel = black;
indice = 3;
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
col_to_add(:,1:2) = 0;
col_to_add(:,3:num_colors) = linspace(0,40,num_colors-2);

myMatrixColor = im2double(myMatrixColor);
myMatrixColor = [myMatrixColor col_to_add'];

clear imdata; clear orig_color; clear num_pixels; clear num_rgb;
clear white; clear black; clear last_pixel; clear indice;
clear test; clear num_colors; clear num_rgb1; clear col_to_add;
clear i;

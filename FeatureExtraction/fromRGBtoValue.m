function fromRGBtoValue(imagePath, colorImagePath)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
	pkg load parallel;
end

piedergb = im2double(imread(imagePath));
[x,y,z] = size(piedergb);
myMatrixColor = extractColor(colorImagePath);
[num_colors,rgb] = size(myMatrixColor);
piedeValue=zeros(x,y,'double');

for i=1:x
    for j=1:y
	    min = realmax;
	    minIndex = 0;
	    % Calcolo delle distanze da ogni centroide.
	    for k=1:num_colors
	      % Calcolo della distanza euclidea 
	      diff = sqrt(sum((squeeze(piedergb(i,j,:))'-myMatrixColor(k, 1:3)).^2));
	      if(diff < min)
		minIndex = k;
		min = diff;
	      end
	    end
	    piedeValue(i,j) = myMatrixColor(minIndex,4);
    end
end

% Salvataggio dell'immagine su un'immagine diversa.
newImagePath = strrep(imagePath, '.png', '');
newImagePath = strcat(newImagePath, '_bn.png');
imwrite(piedeValue, newImagePath);
end

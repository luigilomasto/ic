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

% Il baricentro attraversa la meta' dell'immagine
if ~isequal(whiteCol, middle_col)

        % Trova la prima colonna bianca a sinistra...
	for i=half-1:-1:1
	    actualCol = squeeze(image(:,i,:));
	    if isequal(whiteCol, actualCol);
		break;
	    end
	end



	% ... e a destra.
	for j=half+1:y
	    actualCol = squeeze(image(:,j,:));
	    if isequal(whiteCol, actualCol);
		break;
	    end
	end
	
	% Pulizia
	image(:,(i:half),:) = 1;
	image(:,(half:j),:) = 1;
% Il baricentro non attraversa il centro.
else
	% Calcolo la prima colonna non bianca a sinistra.
	for j=half-1:-1:1
	    actualCol = squeeze(image(:,j,:));
	    if ~isequal(whiteCol, actualCol);
		    break;
	    end
	end

	% Calcolo la prima colonna non bianca a destra.
	for k=half+1:y
	    actualCol = squeeze(image(:,k,:));
	    if ~isequal(whiteCol, actualCol);
		    break;
	    end
	end

	% Quella piu' vicina al centro stabilisce la locazione del baricentro
	kdiff = abs(half - k);
	jdiff = abs(half - j);
	if(jdiff < kdiff)
		% Il baricentro e' a sinistra.
		for i=j:-1:1
		    actualCol = squeeze(image(:,i,:));
		    if isequal(whiteCol, actualCol);
			break;
		    end
		end
		image(:, (i:j),:) = 1;
	else
		% IL baricentro e' a destra.
		for i=k:y
		    actualCol = squeeze(image(:,i,:));
		    if isequal(whiteCol, actualCol);
			break;
		    end
		end
		image(:, (k:i),:) = 1;
	end
end

pathNoExtension = strrep(imagePath, '.png', '');
pathNoExtension = strcat(pathNoExtension, '_cleared.png');
imwrite(image,pathNoExtension);

end

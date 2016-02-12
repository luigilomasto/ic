function [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(pathImage_bn)


isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
end

addPath('..');


piedeValue= im2double(imread(pathImage_bn));

[num_rows,num_cols] = size(piedeValue);
metaPiede=idivide(int32(num_rows),2,'round');

[maxPressureTallone, rectangleTallone] = findCentreOfMaxPressure(piedeValue, true);
[maxPressureAvampiede, rectangleAvampiede] = findCentreOfMaxPressure(piedeValue, false);


positionMaxPressureAvampiede=rectangleAvampiede(1,1);
positionMaxPressureTallone=rectangleTallone(1,1);

%calcoliamo la length media delle righe dell'istmo
left_bound = 1;
right_bound = num_cols;
upper_bound = 1;
lower_bound = num_rows;


lengthMediaIstmo=0;

for i=positionMaxPressureAvampiede:positionMaxPressureTallone
    lengthMediaIstmo=lengthMediaIstmo+sum(piedeValue(i,left_bound:right_bound)>0);
end

lengthMediaIstmo=lengthMediaIstmo/(positionMaxPressureTallone-positionMaxPressureAvampiede+1);
lengthMediaIstmo;


maxIstmoAvampiede=metaPiede;
minIstmoAvampiede=metaPiede;
maxIstmoTallone=metaPiede;
minIstmoTallone=metaPiede;

for i=metaPiede:-1:positionMaxPressureAvampiede
    length = sum(piedeValue(i, left_bound:right_bound) > 0);
    
    if sum(piedeValue(minIstmoAvampiede,left_bound:right_bound)>0)>length
        minIstmoAvampiede=i;
    end

    if sum(piedeValue(maxIstmoAvampiede,left_bound:right_bound)>0)<length
        maxIstmoAvampiede=i;
    end
end

for i=metaPiede:positionMaxPressureTallone
    length = sum(piedeValue(i, left_bound:right_bound) > 0);
    if sum(piedeValue(minIstmoTallone,left_bound:right_bound)>0)>length
        minIstmoTallone=i;
    end

    if sum(piedeValue(maxIstmoTallone,left_bound:right_bound)>0)<length
        maxIstmoTallone=i;
    end
end

if(sum(piedeValue(minIstmoAvampiede,left_bound:right_bound)>0)>sum(piedeValue(minIstmoTallone,left_bound:right_bound)>0))
    minIstmo=minIstmoTallone;
else
    minIstmo=minIstmoAvampiede;
end

if(sum(piedeValue(maxIstmoAvampiede,left_bound:right_bound)>0)>sum(piedeValue(maxIstmoTallone,left_bound:right_bound)>0))
    maxIstmo=maxIstmoAvampiede;
else
    maxIstmo=maxIstmoTallone;
end

lengthMaxIstmo=sum(piedeValue(maxIstmo,left_bound:right_bound)>0);
lengthMinIstmo=sum(piedeValue(minIstmo,left_bound:right_bound)>0);

lengthMaxAvampiede=0;
%rectangleAvampiede
%rectangleTallone
for i=rectangleAvampiede(3,1):rectangleAvampiede(1,1)
   if sum(piedeValue(i,left_bound:right_bound)>0) > lengthMaxAvampiede
      lengthMaxAvampiede=sum(piedeValue(i,left_bound:right_bound)>0);
    end
end

if lengthMinIstmo ~= 0
    indicePatologia=lengthMaxAvampiede/lengthMinIstmo;
else
    indicePatologia=40;
end

somma=0;
count=0;
for i=1:num_rows
    somma=somma+sum(piedeValue(i,1:num_cols));
    count=count+sum(piedeValue(i,1:num_cols)>0);
end
mediumPressure=somma/count;

%piedeValue(maxIstmo,left_bound:right_bound)=1;
%piedeValue(minIstmo,left_bound:right_bound)=1;
%figure(1)
%imshow(piedeValue);

end

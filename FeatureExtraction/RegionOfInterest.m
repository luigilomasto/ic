function [lengthMinIstmo,lengthMaxAvampiede,lunghezzaMediaIstmo] = RegionOfInterest(pathImage_bn)

piedeValue= im2double(imread(pathImage_bn));
%imshow(piedeValue);

[x,y] = size(piedeValue);

metaImmagine=idivide(int32(y), 2, 'round');

whiteVector=ones(1,metaImmagine);


[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);

inizio=upper_bound;
fine=lower_bound;

metaPiede=idivide(int32(upper_bound+lower_bound),2,'round');

[maxPressureTallone, rectangleTallone] = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, true);
[maxPressureAvampiede, rectangleAvampiede] = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, false);

positionMaxPressureAvampiede=rectangleAvampiede(1,1);
positionMaxPressureTallone=rectangleTallone(1,1);

%calcoliamo la lunghezza media delle righe dell'istmo

lunghezzaMediaIstmo=0;

for i=positionMaxPressureAvampiede:positionMaxPressureTallone
    lunghezzaMediaIstmo=lunghezzaMediaIstmo+sum(piedeValue(i,left_bound:right_bound)>0);
end

lunghezzaMediaIstmo=lunghezzaMediaIstmo/(positionMaxPressureTallone-positionMaxPressureAvampiede+1);
lunghezzaMediaIstmo


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
lengthMinIstmo=sum(piedeValue(minIstmo,left_bound:right_bound)>0)

lengthMaxAvampiede=0;
for i=rectangleAvampiede(1,1):rectangleAvampiede(3,1)
   if sum(piedeValue(i,left_bound:right_bound)>0) > lengthMaxAvampiede
      lengthMaxAvampiede=sum(piedeValue(i,left_bound:right_bound)>0);
    end
end


piedeValue(maxIstmo,left_bound:right_bound)=1;
piedeValue(minIstmo,left_bound:right_bound)=1;

figure(1)
imshow(piedeValue);





end


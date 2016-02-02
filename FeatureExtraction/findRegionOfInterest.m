[x,y] = size(piedeValue);

metaImmagine=idivide(int32(y), 2, 'round');

whiteVector=ones(1,metaImmagine);

for i=1:x
    if ~isequal(piedeValue(i,1:metaImmagine), whiteVector)
        break;
    end
end

inizio=i;

for i=x:-1:1
    if ~isequal(piedeValue(i,1:metaImmagine), whiteVector)
        break;
    end
end

fine=i;

metaPiede=(inizio+fine)/2;

positionMaxPressureAvampiede=1;
maxPressureAvampiede=0;

for i=metaPiede:-1:inizio
    for j=1:metaImmagine
        if(piedeValue(i,j) > maxPressureAvampiede)
            maxPressureAvampiede=piedeValue(i,j);
            positionMaxPressureAvampiede=i;    
        end
    end
end

positionMaxPressureTallone=1;
maxPressureTallone=0;
for i=metaPiede:fine
    for j=1:metaImmagine
        if(piedeValue(i,j) > maxPressureTallone)
            maxPressureTallone=piedeValue(i,j);
            positionMaxPressureTallone=i;
            
        end
    end
end

maxIstmoAvampiede=metaPiede;
minIstmoAvampiede=metaPiede;
maxIstmoTallone=metaPiede;
minIstmoTallone=metaPiede;

for i=metaPiede:-1:positionMaxPressureAvampiede
    length = sum(piedeValue(i, 1:metaImmagine) > 0);
    
    if sum(piedeValue(minIstmoAvampiede,1:metaImmagine)>0)>length
        minIstmoAvampiede=i;
    end

    if sum(piedeValue(maxIstmoAvampiede,1:metaImmagine)>0)<length
        maxIstmoAvampiede=i;
    end
end

for i=metaPiede:positionMaxPressureTallone
    length = sum(piedeValue(i, 1:metaImmagine) > 0);
    if sum(piedeValue(minIstmoTallone,1:metaImmagine)>0)>length
        minIstmoTallone=i;
    end

    if sum(piedeValue(maxIstmoTallone,1:metaImmagine)>0)<length
        maxIstmoTallone=i;
    end
end

if(sum(piedeValue(minIstmoAvampiede,1:metaImmagine)>0)>sum(piedeValue(minIstmoTallone,1:metaImmagine)>0))
    minIstmo=minIstmoTallone;
else
    minIstmo=minIstmoAvampiede;
end

if(sum(piedeValue(maxIstmoAvampiede,1:metaImmagine)>0)>sum(piedeValue(maxIstmoTallone,1:metaImmagine)>0))
    maxIstmo=maxIstmoAvampiede;
else
    maxIstmo=maxIstmoTallone;
end


piedergb(maxIstmo, 1:metaImmagine, 1) = 255;
piedergb(maxIstmo, 1:metaImmagine, 2) = 255;
piedergb(maxIstmo, 1:metaImmagine, 3) = 255;

piedergb(minIstmo, 1:metaImmagine, 1) = 0;
piedergb(minIstmo, 1:metaImmagine, 2) = 0;
piedergb(minIstmo, 1:metaImmagine, 3) = 0;

imagesc(piedergb);

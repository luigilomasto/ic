function [ pointTallone, pointAvampiede ] = centreOfMaxPressure(piedeValue)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
end

[x,y] = size(piedeValue);

whiteVector=zeros(1,y);
%vado all'inizio del piede
for i=1:x
    if ~isequal(piedeValue(i,:), whiteVector)
        break;
    end
end
inizio=i;

%fino alla fine del piede
for i=x:-1:1
    if ~isequal(piedeValue(i,:), whiteVector)
        break;
    end
end

fine=i;

metaPiede=(inizio+fine);
metaPiede = idivide(int32(metaPiede), 2, 'round');

rectangleAvampiede=zeros(4,2);
rectangleTallone=zeros(4,2);
rectangleTallone = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, true);
rectangleAvampiede = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, false);

pointTallone=zeros(1,2);
pointAvampiede=zeros(1,2);

pointTallone(1) = idivide(int32(rectangleTallone(1,1)+rectangleTallone(3,1)),2, 'round');
pointTallone(2) = idivide(int32(rectangleTallone(1,2)+rectangleTallone(4,2)),2, 'round');

pointAvampiede(1) = idivide(int32(rectangleAvampiede(1,1)+rectangleAvampiede(3,1)),2, 'round');
pointAvampiede(2) = idivide(int32(rectangleAvampiede(1,2)+rectangleAvampiede(4,2)),2, 'round');

end




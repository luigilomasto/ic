function [ point1, point2 ] = centreOfMaxPressure(piedeValue)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
	pkg load parallel;
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

point1 = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, true);
point2 = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, false);


end




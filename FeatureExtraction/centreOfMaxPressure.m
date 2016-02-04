function [ pointTallone, pointAvampiede ] = centreOfMaxPressure(piedeValue)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image;
end

[x,y] = size(piedeValue);

[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);

inizio = upper_bound;
fine=lower_bound;

metaPiede=(inizio+fine);
metaPiede = idivide(int32(metaPiede), 2, 'round');

[max_value_tallone, rectangleTallone] = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, true);
[max_value_avampiede, rectangleAvampiede] = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, false);

pointTallone=zeros(1,2);
pointAvampiede=zeros(1,2);

pointTallone(1) = idivide(int32(rectangleTallone(1,1)+rectangleTallone(3,1)),2, 'round');
pointTallone(2) = idivide(int32(rectangleTallone(1,2)+rectangleTallone(4,2)),2, 'round');

pointAvampiede(1) = idivide(int32(rectangleAvampiede(1,1)+rectangleAvampiede(3,1)),2, 'round');
pointAvampiede(2) = idivide(int32(rectangleAvampiede(1,2)+rectangleAvampiede(4,2)),2, 'round');

end
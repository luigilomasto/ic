%isLeft: true se il piede e' sinistro, false se e' destro
function [diffPosition] = valgoVaro (pathImage)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image
end

addpath(genpath('..'));

piedeValue= im2double(imread(pathImage));

[pointTallone, pointAvampiede] = centreOfMaxPressure(piedeValue);
[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);
inizioTallone=1; 
fineTallone=1;
first=false;
%pre prendere inizio e fine tallone, in modo da calcolare il centro
for i=1:right_bound
    if(first==false && piedeValue(pointTallone(1),i)~=0)
        first=true;
        inizioTallone=i;
    end
        if(first==true &&  piedeValue(pointTallone(1),i)==0)
           fineTallone=i;
           break;
        end         
end
centroTallone=idivide(int32(fineTallone+inizioTallone),2,'round');
puntoMaxPressione=pointTallone(2);
diffPosition=abs(centroTallone-puntoMaxPressione);

end

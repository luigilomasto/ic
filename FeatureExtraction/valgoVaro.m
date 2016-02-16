%isLeft: true se il piede e' sinistro, false se e' destro
%approssimated: vale 0 se la differenza tra puntoMaxPressure e centroTallone <10, altrimenti vale la differenza.
%distanceBoundLeft e distanceBoundRight indicano la distanca tra il punto
%di massima pressione dall'inizio e la fine del piede.
function [diffPosition,approssimated,distanceBoundLeft,distanceBoundRight] = valgoVaro (pathImage)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load image
end

addpath(genpath('..'));

piedeValue= im2double(imread(pathImage));
[max_value_tallone, rectangleTallone] = findCentreOfMaxPressure(piedeValue, true);
[pointTallone, pointAvampiede] = centreOfMaxPressure(piedeValue);
[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);
inizioTallone=1; 
fineTallone=1;
%pre prendere inizio e fine tallone, in modo da calcolare il centro
for i=1:right_bound
    if(piedeValue(pointTallone(1),i)~=0)
        inizioTallone=i;
        break;
    end
        
end
for j=right_bound:-1:1
    if(piedeValue(pointTallone(1),j)~=0)
        fineTallone=j;
        break;
    end
end

centroTallone=idivide(int32(fineTallone+inizioTallone),2,'round');
puntoMaxPressione=pointTallone(2);
distanceBoundLeft = puntoMaxPressione-left_bound;
distanceBoundRight = right_bound-puntoMaxPressione;
approssimated=abs(centroTallone-puntoMaxPressione);
diffPosition=centroTallone-puntoMaxPressione;

if(abs(centroTallone-puntoMaxPressione)<8)
    approssimated=0;

end

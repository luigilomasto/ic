%isLeft: true se il piede � sinistro, false se � destro
function [puntoMaxPressione,centroTallone,isLeft] = valgoVaro (pathImage,isLeft)

piedeValue= im2double(imread(pathImage));

[pointTallone, pointAvampiede] = centreOfMaxPressure(piedeValue);
[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);

inizioTallone=1; fineTallone=1;
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


end

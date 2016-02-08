%isLeft: true se il piede è sinistro, false se è destro
function [puntoMaxPressione,centroTallone] = valgoVaro (pathImage,isLeft)

piedeValue= im2double(imread(pathImage));

[pointTallone, pointAvampiede] = centreOfMaxPressure(piedeValue);
[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);

inizioTallone=1; fineTallone=1;
first=false;
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

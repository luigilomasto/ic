function point = findCentreOfMaxPressure(piedeValue, inizio, fine, metaPiede, down)

point = zeros(1, 2);
[x,y] = size(piedeValue);

if ~down
    inizioFor = metaPiede;
    fineFor = inizio;
    step = -1;
else
    inizioFor = metaPiede;
    fineFor = x;
    step = 1;
end

firstRowMaxPressureAvampiede=1;
lastRowMaxPressureAvampiede=1;
maxPressureAvampiede=0;

for i=inizioFor:step:fineFor
    if (max(piedeValue(i,:))>maxPressureAvampiede)
            maxPressureAvampiede=max(piedeValue(i,:));
            firstRowMaxPressureAvampiede=i;    
    end
end

for i=firstRowMaxPressureAvampiede:step:fineFor
      if ~(max(piedeValue(i,1:y))==maxPressureAvampiede)
          break;          
      end
end

if ~down
    lastRowMaxPressureAvampiede=i+1;
else
    lastRowMaxPressureAvampiede=i-1;
end

firstColMaxPressureAvampiede=1;
lastColMaxPressureAvampiede=1;

if ~down
    interval = lastRowMaxPressureAvampiede:1:firstRowMaxPressureAvampiede;
else
    interval = firstRowMaxPressureAvampiede:1:lastRowMaxPressureAvampiede;
end

for i=1:y
    actual_max = max(piedeValue(interval,i));
    if actual_max==maxPressureAvampiede
        break;
    end
end

firstColMaxPressureAvampiede=i;

for i=firstColMaxPressureAvampiede:y
 if(max(piedeValue(interval,i))~=maxPressureAvampiede)
        break;
 end
end

lastColMaxPressureAvampiede=i-1;

point(1) = idivide(int32(firstRowMaxPressureAvampiede + lastRowMaxPressureAvampiede), 2, 'round');
point(2) = idivide(int32(firstColMaxPressureAvampiede + lastColMaxPressureAvampiede), 2, 'round');



end
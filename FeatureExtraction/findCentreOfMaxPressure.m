function [max_value, rectangle] = findCentreOfMaxPressure(piedeValue, down)

point = zeros(1, 2);
[x,y] = size(piedeValue);

[left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(piedeValue);

inizio = upper_bound;
fine = lower_bound;

metaPiede=(inizio+fine);
metaPiede = idivide(int32(metaPiede), 2, 'round');

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
rectangle =zeros(4,2);

rectangle(1,1)=firstRowMaxPressureAvampiede;
rectangle(1,2)=firstColMaxPressureAvampiede;
rectangle(2,1)=firstRowMaxPressureAvampiede;
rectangle(2,2)=lastColMaxPressureAvampiede;
rectangle(3,1)=lastRowMaxPressureAvampiede;
rectangle(3,2)=firstColMaxPressureAvampiede;
rectangle(4,1)=lastRowMaxPressureAvampiede;
rectangle(4,2)=lastColMaxPressureAvampiede;

max_value = maxPressureAvampiede;

end
piedergb = im2double(imread('000.bmp'));
[x,y,z] = size(piedergb);
[x1,y1] = size(myMatrixColor);
piedeValue=zeros(x,y,z);

for i=1:x
    for j=1:y
        min = realmax;
        minIndex = 0;
        for k=1:x1
          diff = sqrt(sum((squeeze(piedergb(i,j,:))-myMatrixColor(k, 1:3)).^2));
          if(diff < min)
            minIndex = k;
            min = deltaE;
          end
        end
        piedeValue(i,j,:) = myMatrixColor(minIndex,1:3);
    end
end
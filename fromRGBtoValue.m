piedergb = im2double(imread('000.bmp'));
%myMatrixColorDouble = im2double(myMatrixColor);
[x,y,z] = size(piedergb);
[x1,y1] = size(myMatrixColorDouble2);
piedeImg=zeros(x,y,z);
piedeValue=zeros(x,y);
tic
parfor i=1:x
    for j=1:y
        min = realmax;
        minIndex = 0;
        for k=1:x1
          diff = sqrt(sum((squeeze(piedergb(i,j,:))'-myMatrixColorDouble2(k, 1:3)).^2));
          if(diff < min)
            minIndex = k;
            min = diff;
          end
        end
        piedeImg(i,j,:) = myMatrixColorDouble2(minIndex, 1:3);
        piedeValue(i,j) = myMatrixColorDouble2(minIndex,4);
    end
end
clear x; clear y; clear z; clear minIndex; clear min; clear diff; clear i;
clear j; clear k; clear x1; clear y1;
toc
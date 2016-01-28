piedergb = imread("000.bmp");
lab_image = rgb2lab(piedergb);
lab_colors = rgb2lab(myMatrixColor);
clear piedergb;
[x,y,z] = size(lab_image);
[x1,y1] = size(lab_colors);
piedeValue=zeros(x,y,z);
indice=1;

for i=1:x
    for j=1:y
        min = 1000;
        for k=1:x1
          matrix(1,:) = lab_image(i,j,:);
          matrix(2,:) = lab_colors(k,1:3);
          deltaE = sqrt((matrix(1,1)-matrix(2,1))^2 + (matrix(1,2)-matrix(2,2))^2 + (matrix(3,1)-matrix(3,2))^2);
          if(deltaE < min)
            minIndex = k;
            min = deltaE;
          end
        end
        piedeValue(i,j,:) = lab_colors(i,j,:);
    end
end

final_image = lab2rgb(piedeValue);


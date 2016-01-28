imdata = imread('colori.bmp');
orig_color=imdata(9,:,:);

myMatrixColor=zeros(20,3);
indice=1;
% for i=1:812
%     actualPixel=color(1,i,:);
%     for j=i+1:812
%         if actualPixel==color(1,j,:)
%             tmp=[1000,1000,1000];
%             color(1,j,:)=tmp;
%         end
%     end
% end
i=20;
j=60;
while(i<812)
    actualPixel=orig_color(1,i,:);
    while(j<812)
         myMatrixColor(indice,:)= squeeze(orig_color(1,j,:));
         indice=indice+1;
        j=j+40;
    end
     i=i+40;
end
% colorAsMatrix = squeeze(myMatrixColor(1,:,:));
% result=unique(colorAsMatrix,'rows');
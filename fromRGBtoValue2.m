[x,y,z] = size(piedergb);
%piedeValue=zeros(x,y);
matrix=zeros(2,3);
for i=1:x
    for j=1:y
        min = 1000;
        minIndex=0;
        for k=1:21
            matrix(1,:)=piedergb(i,j,:);
            matrix(2,:)=myMatrixColor(k,1:3);
            app=0;
            app=pdist(matrix,'euclidean');
            if(app<min)
                minIndex=k;
                min=app;
            end
        end
        piedeValue(i,j)=myMatrixColor(minIndex, 4);
    end
end

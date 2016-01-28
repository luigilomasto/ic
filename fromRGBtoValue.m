[x,y,z] = size(piedergb);
piedeValue=zeros(x,y);
notExistent;
indice=1;
found_equal = false;
for i=1:x
    for j=1:y
        for k=1:40
            if (piedergb(i,j,1)==super_matrix(k,1) && piedergb(i,j,2)==super_matrix(k,2) && piedergb(i,j,3)==super_matrix(k,3))
                piedeValue(i,j)=super_matrix(k,4);
                found_equal = true;
                break;
            end
        end
        if ~found_equal
            notExistent(indice, :) = piedergb(i,j,:);
            indice = indice + 1;
        end
        found_equal = false;
    end
end

notExistent = unique(notExistent, 'rows')
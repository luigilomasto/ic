function [ featuresMatrix ] = featuresSelectionSVM(classificationType,typeNormalization,classifierType)

if  strcmp(classificationType,'first')==1
    featuresRange= 3:8;
    
elseif strcmp(classificationType,'second')==1
    featuresRange = 3:6;
    
end
sizeMatrix=0;
for i=1:length(featuresRange)
    combos = nchoosek(featuresRange,i);
    [numRows,numCols]=size(combos);
    sizeMatrix=sizeMatrix+numRows;
end

featuresMatrix=zeros(sizeMatrix,length(featuresRange)+1);
index=1;

for i=1:length(featuresRange)
    combos = nchoosek(featuresRange,i);
    [numRows,numCols]=size(combos);
    total_accuracy=0;
    for j=1:numRows
        if(strcmp(classifierType,'linear')==1)
        [total_accuracy,results,real_results,vectorAccuracy,c_coefficient] = SVMLinear (classificationType,typeNormalization,combos(j,:));
        elseif(strcmp(classifierType,'rbf')==1)
        [total_accuracy,results,real_results,vectorAccuracy,c_coefficient,gamma_coefficient] = SVMRBF(classificationType,typeNormalization,combos(j,:));
        elseif(strcmp(classifierType,'polynomial')==1)
        [total_accuracy,results,real_results,vectorAccuracy,c_coefficient, d_coefficient] = SVMPolynomial (classificationType,typeNormalization,combos(j,:));   
        end
        
        featuresMatrix(index,length(featuresRange)+1) = total_accuracy;
        tempVector=combos(j,:)-2;
        featuresMatrix(index,tempVector)=1;
        index=index+1;
        
    end
    
end

end


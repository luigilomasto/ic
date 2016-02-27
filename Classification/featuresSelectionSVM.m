function [ featuresMatrix,testMatrix,total_accuracy ] = featuresSelectionSVM(classificationType,typeNormalization,classifierType)

if  strcmp(classificationType,'first')==1
    featuresRange= 3:7;
    %featuresRange=[3 4 5 8 10 11];
    
elseif strcmp(classificationType,'second')==1
    featuresRange = 3:6;
    
end
sizeMatrix=0;
for i=1:length(featuresRange)
    combos = nchoosek(featuresRange,i);
    [numRows,numCols]=size(combos);
    sizeMatrix=sizeMatrix+numRows;
end

featuresMatrix=zeros(sizeMatrix,length(featuresRange)+4);
index=1;

for i=1:length(featuresRange)
    combos = nchoosek(featuresRange,i);
    [numRows,numCols]=size(combos);
    total_accuracy=0;
    for j=1:numRows
        if(strcmp(classifierType,'linear')==1)
            [total_accuracy,results,real_results,vectorAccuracy,c1,c2,c3,testMatrix, total_accuracy] = SVMLinear (classificationType,typeNormalization,combos(j,:));
        elseif(strcmp(classifierType,'rbf')==1)
            [total_accuracy,results,real_results,vectorAccuracy,c1,c2,c3] = SVMRBF(classificationType,typeNormalization,combos(j,:));
        elseif(strcmp(classifierType,'polynomial')==1)
            [total_accuracy,results,real_results,vectorAccuracy,c d_coefficient,c1,c2,c3] = SVMPolynomial (classificationType,typeNormalization,combos(j,:));   
        end
        
        featuresMatrix(index,length(featuresRange)+1) = total_accuracy;
        featuresMatrix(index,length(featuresRange)+2) = c1;
        featuresMatrix(index,length(featuresRange)+3) = c2;
        featuresMatrix(index,length(featuresRange)+4) = c3;
        %per scalare le features
        %tempVector=combos(j,:)-2;
        for s=1:length(combos(j,:))
            val=combos(j,s);
            featuresMatrix(index,find(featuresRange == val))=1;
        end
        index=index+1;
        
    end
    
end

end


function [splits] = CV_createSplits(Labels,NumFolds,NumRep,mode)


uLabels = unique(Labels);
nClasses = numel(uLabels);
Classes = cell(1,nClasses);
ClassesP = cell(1,nClasses);
Ctot = [];
ClassSamp = numel(Labels) + 1;
for indCl=1:nClasses
    Classes{indCl} = find(Labels == uLabels(indCl));
    Ctot = union(Ctot,Classes{indCl});
    ClassSamp = min(ClassSamp,numel(Classes{indCl}));
end



% stratified cross-validation (per class)
if(exist('mode','var'))
    switch(mode)
        case 'floor'
            SampPerFold = floor(ClassSamp/NumFolds);
        case 'ceil'
            SampPerFold = ceil(ClassSamp/NumFolds);
        otherwise
            SampPerFold = floor(ClassSamp/NumFolds);
    end
else
    SampPerFold = floor(ClassSamp/NumFolds);
end
splits      = cell(1,NumFolds*NumRep);
for indRep  = 1:NumRep
    
    for indFold = 1:NumFolds
        
        splits{NumFolds*(indRep-1) + indFold}.indTrain = [];
        splits{NumFolds*(indRep-1) + indFold}.indTest = [];
        
        if indFold < NumFolds
            ind_test = 1+SampPerFold*(indFold-1):SampPerFold*indFold;
        else
            ind_test  = 1+SampPerFold*(indFold-1):ClassSamp;
        end
        for indCl=1:nClasses
            
            ClassPerm = Classes{indCl}(randperm(numel(Classes{indCl})));
            
            ClassTest   = ClassPerm(ind_test);
            ClassTrain  = setdiff(ClassPerm,ClassTest);
                        
            splits{NumFolds*(indRep-1) + indFold}.indTrain  = [splits{NumFolds*(indRep-1) + indFold}.indTrain; ClassTrain(:)];
            splits{NumFolds*(indRep-1) + indFold}.indTest   = [splits{NumFolds*(indRep-1) + indFold}.indTest; ClassTest(:)];
        end
        
        
    end
end

% LOO
% splits = cell(1,numel(Ctot));
% for ind = 1:numel(Ctot)
%     splits{ind}.indTest    = Ctot(ind);
%     splits{ind}.indTrain   = setdiff(Ctot,ind);
% end


end


function [ftRank,ftScore] = featureSelection( classificationType )

labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

if  strcmp(classificationType,'first')==1
    load 'fullMatrix1standard.mat' fullMatrix;
    %[ftRank,ftScore] = ftSel_SVMRFECBR(fullMatrix(:,3:7),fullMatrix(:,8));
    [ftRank,ftScore, latent] = princomp(fullMatrix(:,3:7),fullMatrix(:,8));
else
    load 'fullMatrix2standard.mat' fullMatrix;
    %[ftRank,ftScore] = ftSel_SVMRFECBR(fullMatrix(:,3:6),fullMatrix(:,7));
    [ftRank,ftScore, latent] = princomp(fullMatrix(:,3:6),fullMatrix(:,7));
    
end
end


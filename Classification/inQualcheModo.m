
labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

%load 'fullMatrix1standard.mat' fullMatrix;
load 'fullMatrix2standard.mat' fullMatrix;

%[ftRank,ftScore] = ftSel_SVMRFECBR(fullMatrix(:,3:7),fullMatrix(:,8));
[ftRank,ftScore] = ftSel_SVMRFECBR(fullMatrix(:,2:7),fullMatrix(:,7));

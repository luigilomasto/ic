
labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
%fullMatrix = FeaturesSecondClassifier(labelsPath, dataPath);

[ftRank,ftScore] = ftSel_SVMRFECBR(fullMatrix(:,3:7),fullMatrix(:,8));
%[ftRank,ftScore] = ftSel_SVMRFECBR(fullMatrix(:,2:3),fullMatrix(:,4));

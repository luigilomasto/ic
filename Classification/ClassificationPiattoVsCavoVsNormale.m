labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

numRip=5;
numFold=2;
fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
featuresRange=3:7;
percentuale=0;


for i=1:numRip
    c = cvpartition(fullMatrix(:,8),'KFold',2);
    train=training(c,1);
    test=test(c,2);
    
    trainingSetRange = find(train)';
    testSetRange=find(test)';

    trainingPatients = fullMatrix(trainingSetRange, 1);
    trainingSet = fullMatrix(trainingSetRange, featuresRange);
    testPatients = fullMatrix(testSetRange, 1);
    testSet=fullMatrix(testSetRange, featuresRange);
    label = fullMatrix(trainingSetRange, 8);
    results = multisvm(trainingSet, label', testSet);
    real_results = fullMatrix(testSetRange, 8);
    good_classified = (results == real_results);
    perc_good_classified = sum(good_classified)/length(good_classified);
    
    percentuale = percentuale+perc_good_classified;
    clear test train c;
end
percentuale = percentuale/numRip;
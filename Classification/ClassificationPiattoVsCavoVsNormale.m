labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

numRip=10;
numFold=2;
fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
featuresRange=3:7;
perc_totale_good=0;
accuratezza_1 = 0;
accuratezza_2 = 0;
accuratezza_3 = 0;

for i=1:numRip
    c = cvpartition(fullMatrix(:,8),'KFold',2);
    train=training(c,1);
    test=test(c,1);
    
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
    
    perc_totale_good = perc_totale_good+perc_good_classified;
    tab = crosstab(results, real_results);
    accuratezza_1 = accuratezza_1 + tab(1,1)/sum(tab(:,1));
    accuratezza_2 = accuratezza_2 + tab(2,2)/sum(tab(:,2));
    accuratezza_3 = accuratezza_3 + tab(3,3)/sum(tab(:,3));
    clear test train c;
end
perc_totale_good = perc_totale_good/numRip;
accuratezza_1 = accuratezza_1/numRip;
accuratezza_2 = accuratezza_2/numRip;
accuratezza_3 = accuratezza_3/numRip;
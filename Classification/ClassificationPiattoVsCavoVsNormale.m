labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

featuresRange=3:7;
trainingSetRange = 1:40;
testSetRange=41:100;

fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
trainingPatients = fullMatrix(trainingSetRange, 1);
trainingSet = fullMatrix(trainingSetRange, featuresRange);
testPatients = fullMatrix(testSetRange, 1);
testSet=fullMatrix(testSetRange, featuresRange);
label = fullMatrix(trainingSetRange, 8);
results = multisvm(trainingSet, label', testSet);
real_results = fullMatrix(testSetRange, 8);
good_classified = (results == real_results);
perc_good_classified = sum(good_classified)/length(good_classified);

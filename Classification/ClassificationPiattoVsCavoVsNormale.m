function [results, perc_good_classified] = ClassificationPiattoVsCavoVsNormale(labelsPath, dataPath)

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
trainingSetRange = 1:40;
trainingPatients = fullMatrix(trainingSetRange, 1);
trainingSet = fullMatrix(trainingSetRange, 3:7);
testSetRange=41:100;
testPatients = fullMatrix(testSetRange, 1);
testSet=fullMatrix(testSetRange, 3:7);
label = fullMatrix(trainingSetRange, 8);
results = multisvm(trainingSet, label', testSet);
real_results = fullMatrix(testSetRange, 8);
good_classified = (results == real_results);
perc_good_classified = sum(good_classified)/length(good_classified);

end

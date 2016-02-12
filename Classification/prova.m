isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

fullMatrix = FeaturesFirstClassifier('/home/marco/labels.csv', '/home/marco/DatiPreprocessedFixed/');
trainingSetRange = 1:40;
trainingPatients = fullMatrix(trainingSetRange, 1);
training = fullMatrix(trainingSetRange, 3:7);
%SVMStruct = svmtrain(training,label');
testSetRange=41:100;
testPatients = fullMatrix(testSetRange, 1);
test=fullMatrix(testSetRange, 3:7);
%Group = svmclassify(SVMStruct,test);
label = fullMatrix(trainingSetRange, 8);
results = multisvm(training, label', test);
real_results = fullMatrix(testSetRange, 8);
good_classified = (results == real_results);
perc_good_classified = sum(good_classified)/length(good_classified);
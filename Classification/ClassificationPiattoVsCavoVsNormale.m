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
%FeaturesRange can be changed with RFE
featuresRange = 3:7;
label_column = 8;
total_accuracy = 0;
num_classes = unique(fullMatrix(:,label_column));
class_accuracy = zeros(length(num_classes));

for i=1:numRip
    c = cvpartition(fullMatrix(:,label_column),'KFold',2);
    train=training(c,1);
    test=test(c,1);
    
    trainingSetRange = find(train)';
    testSetRange=find(test)';

    trainingSet = fullMatrix(trainingSetRange, featuresRange);
    testSet=fullMatrix(testSetRange, featuresRange);
    label = fullMatrix(trainingSetRange, label_column);
    results = multisvm(trainingSet, label', testSet);
    real_results = fullMatrix(testSetRange, label_column);
    total_accuracy = total_accuracy + sum(results == real_results)/length(results);
    tab = crosstab(results, real_results);
    for j=1:num_classes
        class_accuracy(j) = class_accuracy(j) + tab(j,j)/sum(tab(:,j));
    end
    clear test train c;
end
perc_totale_good = perc_totale_good/numRip;
for j=1:num_classes
    class_accuracy(j) = class_accuracy(j)/numRip;
end

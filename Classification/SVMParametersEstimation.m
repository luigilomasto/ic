function SVMParametersEstimation(classificationType, filename)

labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

if  strcmp(classificationType,'first')==1
    fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
    featuresRange= 3:7;
    %featuresRange = [6 5 3];
    label_column = 8;
elseif strcmp(classificationType,'second')==1
    fullMatrix = FeaturesSecondClassifier(labelsPath, dataPath);
    featuresRange = [3];
    label_column = 4;
end

trainingSetFeatures = fullMatrix(:, featuresRange);
trainingSetLabels = fullMatrix(:, label_column);

trainingFile = fopen(filename, 'w');

[num_instances_train, num_features] = size(trainingSetFeatures);

if strcmp(classificationType,'first')==1
 for i=1:num_instances_train
    fprintf(trainingFile, "%d 1:%e 2:%e 3:%e 4:%e 5:%e\n", int32(trainingSetLabels(i,1)), trainingSetFeatures(i,1), trainingSetFeatures(i,2), trainingSetFeatures(i,3), trainingSetFeatures(i,4), trainingSetFeatures(i,5));
 end
end

fclose(trainingFile);

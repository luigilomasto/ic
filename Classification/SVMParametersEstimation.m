function SVMParametersEstimation(classificationType,typeNormalization,filename)

labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

if  strcmp(classificationType,'first')==1
   if strcmp(typeNormalization,'standard')==1
   load 'fullMatrix1standard.mat' fullMatrix;
   else
   load 'fullMatrix1scaling.mat' fullMatrix;
   end
   %fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
   featuresRange= 3:7;
   %featuresRange = [6 5 3];
   label_column = 8;
   ConfusionMatrix=zeros(3,3,'double');


elseif strcmp(classificationType,'second')==1
   if strcmp(typeNormalization,'scaling')==1
   load 'fullMatrix2standard.mat' fullMatrix;
   else
   load 'fullMatrix2scaling.mat' fullMatrix;
   end
    %fullMatrix = FeaturesSecondClassifier(labelsPath, dataPath);
    featuresRange = 2:6;
    %featuresRange = [5 4];
    label_column = 7;
    ConfusionMatrix=zeros(2,2,'double');
end

trainingSetFeatures = fullMatrix(:, featuresRange);
trainingSetLabels = fullMatrix(:, label_column);

trainingFile = fopen(filename, 'w');

[num_instances_train, num_features] = size(trainingSetFeatures);

if strcmp(classificationType,'first')==1
 for i=1:num_instances_train
    fprintf(trainingFile, '%d 1:%e 2:%e 3:%e 4:%e 5:%e\n', int32(trainingSetLabels(i,1)), trainingSetFeatures(i,1), trainingSetFeatures(i,2), trainingSetFeatures(i,3), trainingSetFeatures(i,4), trainingSetFeatures(i,5));
 end
end

if strcmp(classificationType,'second')==1
 for i=1:num_instances_train
    fprintf(trainingFile, '%d 1:%e 2:%e 3:%e 4:%e 5:%e\n', int32(trainingSetLabels(i,1)), trainingSetFeatures(i,1), trainingSetFeatures(i,2), trainingSetFeatures(i,3), trainingSetFeatures(i,4), trainingSetFeatures(i,5));
 end
end

fclose(trainingFile);

classificationType = 'first';
typeNormalization = 'standard';
featuresRange = [3 5 11];
labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
    pkg load statistics;
end

addpath(genpath('..'));

if  strcmp(classificationType,'first')==1
    if strcmp(typeNormalization,'standard')==1
        load 'fullMatrix1standard_new.mat' fullMatrix;
    else
        load 'fullMatrix1scaling_new.mat' fullMatrix;
    end
    %fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
    %featuresRange= 3:7;
    %featuresRange = [3 5];
    label_column = 12;
    ConfusionMatrix=zeros(3,3,'double');
    numFold=190;
    
    
elseif strcmp(classificationType,'second')==1
    if strcmp(typeNormalization,'scaling')==1
        load 'fullMatrix2standard.mat' fullMatrix;
    else
        load 'fullMatrix2scaling.mat' fullMatrix;
    end
    %fullMatrix = FeaturesSecondClassifier(labelsPath, dataPath);
    %featuresRange = 3:6;
    %featuresRange = [3 4];
    label_column = 7;
    ConfusionMatrix=zeros(2,2,'double');
    numFold=10;
    
end

total_accuracy = 0;
num_classes = length(unique(fullMatrix(:,label_column)));
class_accuracy = zeros(num_classes, 1);

detected = 0;
result_classes = zeros(numFold,1);
real_results_classes = zeros(numFold,1);
index = 1;
c = cvpartition(length(fullMatrix(:,label_column)), 'LeaveOut');
for j=1:numFold
firstTrainBinary=training(c,j);
firstTestBinary=test(c,j);
firstTrainingSetRange = find(firstTrainBinary)';
firstTestSetRange=find(firstTestBinary)';
testMatrix = fullMatrix(firstTestSetRange, :);
real_result = testMatrix(:,label_column);
trainMatrix = fullMatrix(firstTrainingSetRange, :);
trainLabel = trainMatrix(:,label_column);
model = svmtrain(trainLabel,trainMatrix);
result = svmpredict(real_result,testMatrix,model);
result_classes(index) = result;
real_results_classes(index) = real_result;
index = index + 1;
if result == real_result
    detected = detected+1;
end
end
confusion = confusionmat(result_classes, real_results_classes);

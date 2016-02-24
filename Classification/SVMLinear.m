
function [total_accuracy,results,real_results,vectorAccuracy,c_coefficient] = SVMLinear (classificationType,typeNormalization,featuresRange)

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
    featuresRange= 3:8;
    %featuresRange = [3 5];
    label_column = 9;
    ConfusionMatrix=zeros(3,3,'double');
    numFold=5;
    
    
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


%%divido il dataset in training e test
c = cvpartition(fullMatrix(:,label_column),'KFold',numFold);
firstTrainBinary=training(c,1);
firstTestBinary=test(c,1);
firstTrainingSetRange = find(firstTrainBinary)';
firstTestSetRange=find(firstTestBinary)';
trainMatrix = fullMatrix(firstTrainingSetRange, :);

clear test train c;
vectorAccuracy=zeros(2+numFold,21); % la prima riga avrà l'esponente, la seconda la media, e le restanti avranno le accuratezze

for i=-3:3
    c_coefficient=10^i;
    setup=sprintf('-c %d', c_coefficient);
    
    c = cvpartition(trainMatrix(:,label_column),'KFold',numFold);
    avarage_accuracy=0;
    for j=1:numFold
        trainBinary=training(c,j);
        testBinary=test(c,j);
        
        trainingSetRange = find(trainBinary)';
        testSetRange=find(testBinary)';
        
        trainingSet = trainMatrix(trainingSetRange, featuresRange);
        testSet=trainMatrix(testSetRange, featuresRange);
        trainLabel = trainMatrix(trainingSetRange, label_column);
        
        model = svmtrain(trainLabel,trainingSet,setup);
        real_results = trainMatrix(testSetRange, label_column);
        [results, accuracy, decision_values] = svmpredict(real_results,testSet,model);
        avarage_accuracy=avarage_accuracy+accuracy(1);
        confusionmat(results,real_results);
        vectorAccuracy(j+2,i+11)=accuracy(1);
    end
    
    avarage_accuracy=avarage_accuracy/numFold;
    total_accuracy = total_accuracy + accuracy(1);
    vectorAccuracy(1,i+11)=i;
    vectorAccuracy(2,i+11)=avarage_accuracy;
    clear test train c;
    confusionmat(results,real_results);
    ConfusionMatrix = ConfusionMatrix+confusionmat(results,real_results);
end


%FASE DI TEST

actualC=1;
actualAccuracy=1;
for i=1:20
    x = vectorAccuracy(3:numFold+2,i);
    y = vectorAccuracy(3:numFold+2,i+1);
    [h] = ttest2(x,y);
    if(h==1)
        if(vectorAccuracy(2,i)>vectorAccuracy(2,i+1) & vectorAccuracy(2,i)>actualAccuracy)
            actualC=vectorAccuracy(1,i);
            actualAccuracy=vectorAccuracy(2,i);
        elseif(vectorAccuracy(2,i+1)>vectorAccuracy(2,i) & vectorAccuracy(2,i+1)>actualAccuracy)
            actualC=vectorAccuracy(1,i+1);
            actualAccuracy=vectorAccuracy(2,i+1);
        end
    end
end

c_coefficient=10^actualC;
setup=sprintf('-c %f', c_coefficient);

trainingSet = fullMatrix(firstTrainingSetRange, featuresRange);
testSet=fullMatrix(firstTestSetRange, featuresRange);
trainLabel = fullMatrix(firstTrainingSetRange, label_column);

model = svmtrain(trainLabel,trainingSet,setup);
real_results = fullMatrix(firstTestSetRange, label_column);
[results, accuracy, decision_values] = svmpredict(real_results,testSet,model);

total_accuracy = accuracy(1);

confusionmat(results,real_results)

end


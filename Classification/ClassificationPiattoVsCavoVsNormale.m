
function [total_accuracy,results,real_results,resultROC,result_realROC,ROC] = ClassificationPiattoVsCavoVsNormale (classificationType)

labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

numRip=5;
numFold=2;



if  strcmp(classificationType,'first')==1
    load 'fullMatrix1.mat' fullMatrix;
    %fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
   %featuresRange= 3:7;
    featuresRange = [6 5 3];
    label_column = 8;


elseif strcmp(classificationType,'second')==1
    %fullMatrix = FeaturesSecondClassifier(labelsPath, dataPath);
    load 'fullMatrix2.mat' fullMatrix;
    %featuresRange = 2:6;
    featuresRange = [6 5 4];
    label_column = 7;
end

% figure
% app=find(fullMatrix(:,7)==1);
% plot(fullMatrix(app,5),fullMatrix(app,6),'or');
% hold on
% app2=find(fullMatrix(:,7)==2);
% plot(fullMatrix(app2,5),fullMatrix(app2,6),'og');

total_accuracy = 0;
num_classes = length(unique(fullMatrix(:,label_column)));
class_accuracy = zeros(num_classes, 1);


 c = cvpartition(fullMatrix(:,label_column),'KFold',2);
 trainBinary=training(c,1);
 testBinary=test(c,1);   
 trainingSetRange = find(trainBinary)';
 testSetRange=find(testBinary)';
 
 resultROC=zeros(length(testSetRange),numRip);
 result_realROC=zeros(length(testSetRange),numRip);
 ROC=zeros(3,numRip);
 clear test train c;
 
for i=1:numRip
    c = cvpartition(fullMatrix(:,label_column),'KFold',2);
    trainBinary=training(c,1);
    testBinary=test(c,1);
    
    trainingSetRange = find(trainBinary)';
    testSetRange=find(testBinary)';

    trainingSet = fullMatrix(trainingSetRange, featuresRange);
    testSet=fullMatrix(testSetRange, featuresRange);
    trainLabel = fullMatrix(trainingSetRange, label_column);
    
    %results = multisvm(trainingSet, label', testSet);
    
    model = svmtrain(trainLabel,trainingSet);
    real_results = fullMatrix(testSetRange, label_column);
    [results, accuracy, decision_values] = svmpredict(real_results,testSet,model); 
    
    
    resultROC(:,i)=results;
    result_realROC(:,i)=real_results;
    
    
    
    for j=1:numRip
        veriPositivi=0;
        falsiPositivi=0;
        for k=1:length(testSetRange)
            if resultROC(k,j)==result_realROC(k,j)
                veriPositivi=veriPositivi+1;
            else
                falsiPositivi=falsiPositivi+1;
            end
        end
    ROC(1,j)=veriPositivi;
    ROC(2,j)=falsiPositivi;
    ROC(3,j)=(veriPositivi/(veriPositivi+falsiPositivi))*100;
    end
    
    
    total_accuracy = total_accuracy + accuracy(1);
    clear test train c;
end

total_accuracy = total_accuracy/numRip;
end
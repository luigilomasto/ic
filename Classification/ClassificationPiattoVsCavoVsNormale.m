
function [total_accuracy,results,real_results,resultROC,result_realROC] = ClassificationPiattoVsCavoVsNormale (classificationType)



labelsPath = '../labels.csv';
dataPath = '../DatiPreprocessed/';

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

addpath(genpath('..'));

numRip=10;
numFold=2;



if  strcmp(classificationType,'first')==1
    fullMatrix = FeaturesFirstClassifier(labelsPath, dataPath);
   %featuresRange= 3:7;
    featuresRange = [6 5 3];
    label_column = 8;


elseif strcmp(classificationType,'second')==1
    fullMatrix = FeaturesSecondClassifier(labelsPath, dataPath);
    
    %featuresRange = 2:3;
    featuresRange = [3];
    label_column = 4;
end


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
   
   
    total_accuracy = total_accuracy + accuracy(1);
    
   
    
    
    
% %     tab = crosstab(real_results, results);
% %     [x, y] = size(tab);
% %     if x == 2 && y == 3
% %         tab(3,:)=[0,0,0];
% % %     end
% %     for j=1:num_classes
% %         class_accuracy(j) = class_accuracy(j) + tab(j,j)/sum(tab(:,j));
% %     end
    clear test train c;
end


total_accuracy = total_accuracy/numRip;
% for j=1:num_classes
%     class_accuracy(j) = class_accuracy(j)/numRip;
% end




end
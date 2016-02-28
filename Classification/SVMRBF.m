function [results,real_results,vectorAccuracy,c_coefficient,gamma_coefficient,ClassesAccuracyForRepetition] = SVMRBF (classificationType,typeNormalization,featuresRange, numRip)
    %ho tolto i valori restituiti delle accuratezze medie parziali e totali
    %perche' basta fare mean sulle colonne di ClassesAccuracyForRepetition
    %per averle
    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
    if isOctave
        pkg load statistics;
    end

    addpath(genpath('..'));

    if  strcmp(classificationType,'first')==1
        if strcmp(typeNormalization,'standard')==1
            load('fullMatrix1standard_new.mat');
        else
            load('fullMatrix1scaling_new.mat');
        end
        numFold=5;    
    elseif strcmp(classificationType,'second')==1
        if strcmp(typeNormalization,'standard')==1
            load('fullMatrix2standard_new.mat');
        else
            load('fullMatrix2scaling_new.mat');
        end
        numFold=5;
    end

    [num_samples, num_features_plus_labels] = size(fullMatrix);
    label_column = num_features_plus_labels;
    num_classes = length(unique(fullMatrix(:,label_column)));
    %ConfusionMatrix=zeros(num_classes,num_classes, 'double');

    %One column for each class accuracy + 1 column for global accuracy
    %One row for each repetition
    ClassesAccuracyForRepetition = zeros(numRip, num_classes + 1); 
    
    for rip=1:numRip
        %%divido il dataset in training e test
        c = cvpartition(fullMatrix(:,label_column),'KFold',numFold);

        firstTrainBinary=training(c,1);
        firstTestBinary=test(c,1);
        firstTrainingSetRange = find(firstTrainBinary)';
        firstTestSetRange=find(firstTestBinary)';
        trainMatrix = fullMatrix(firstTrainingSetRange, :);

        clear test train c;
        CRange = -3:3;
        GammaRange =-2:0;
        numCols=length(CRange)*length(GammaRange);
        % la prima riga avra' l'esponente, la seconda la gamma, 
        %la terza gamma, e le restanti avranno le accuratezze
        vectorAccuracy=zeros(3+numFold,numCols); 
        numCol=1;
        for i=CRange
            c_coefficient=10^i;
            for k=GammaRange
                gamma=10^k;
                setup=sprintf('-c %f -g %f -t %d' , c_coefficient, gamma, 2);
                
                c = cvpartition(trainMatrix(:,label_column),'KFold',numFold);
                %average accuracy for this configuration
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
                    %useful for prints
                    %confusionmat(results,real_results);
                    vectorAccuracy(j+3,numCol)=accuracy(1);
                end
                
                avarage_accuracy=avarage_accuracy/numFold;
                %total_accuracy = total_accuracy + accuracy(1);
                vectorAccuracy(1,numCol)=i;
                vectorAccuracy(2,numCol)=k;
                vectorAccuracy(3,numCol)=avarage_accuracy;
                clear test train c;
                %confusionmat(results,real_results);
                %ConfusionMatrix = ConfusionMatrix+confusionmat(results,real_results);
                numCol=numCol+1;
            end
        end


        %FASE DI TEST

        %scelta dei parametri migliori
        actualAccuracy=1;
        actualC = 1;
        actualGamma= 1;
        %per ogni coppia
        for i=1:length(vectorAccuracy)-1
            x = vectorAccuracy(4:size(vectorAccuracy, 1),i);
            y = vectorAccuracy(4:size(vectorAccuracy,1),i+1);
            %ttest
            [h] = ttest2(x,y);
            if(h==1)
                if(vectorAccuracy(3,i)>vectorAccuracy(3,i+1) & vectorAccuracy(3,i)>actualAccuracy)
                    actualAccuracy=vectorAccuracy(3,i);
                    actualC=vectorAccuracy(1,i);
                    actualGamma=vectorAccuracy(2,i);
                elseif(vectorAccuracy(3,i+1)>vectorAccuracy(3,i) & vectorAccuracy(3,i+1)>actualAccuracy)
                    actualC=vectorAccuracy(1,i+1);
                    actualAccuracy=vectorAccuracy(3,i+1);
                    actualGamma=vectorAccuracy(2,i+1);
                end
            end
        end

        c_coefficient=10^actualC;
        gamma_coefficient=10^actualGamma;
        setup=sprintf('-c %f -g %f -t %d', c_coefficient,gamma_coefficient,2);

        trainingSet = fullMatrix(firstTrainingSetRange, featuresRange);
        testSet=fullMatrix(firstTestSetRange, featuresRange);
        trainLabel = fullMatrix(firstTrainingSetRange, label_column);

        model = svmtrain(trainLabel,trainingSet,setup);
        real_results = fullMatrix(firstTestSetRange, label_column);
        [results, accuracy, decision_values] = svmpredict(real_results,testSet,model);

        total_accuracy = accuracy(1);

        ConfusionMat = confusionmat(results, real_results);
        
        for i=1:num_classes
            ClassesAccuracyForRepetition(rip, i) = (ConfusionMat(i,i)/sum(ConfusionMat(:,i)))*100;
        end

        ClassesAccuracyForRepetition(rip, num_classes+1) = total_accuracy;        
    end %end numRip loop 
end
training=FeaturesFirstClassifier (5);
label=zeros(10);
label=[1 1 2 2 3 3 1 1 1 1];
%SVMStruct = svmtrain(training,label');
test=FeaturesFirstClassifier (30);
%Group = svmclassify(SVMStruct,test);
results = multisvm(training, label, test); 
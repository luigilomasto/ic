isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
	pkg load statistics;
end

fullMatrix = FeaturesFirstClassifier(0,322);
label=[1 1 2 2 3 3 1 1 1 1 3 3 3 3 1 1 3 3 1 1 3 3 3 3 1 1 1 1 1 1 3 3 3 3 3 3 1 3 3 3]';
training = fullMatrix(1:40, 1)
%SVMStruct = svmtrain(training,label');
test=fullMatrix(41:100, 1);
%Group = svmclassify(SVMStruct,test);
results = multisvm(training, label, test); 
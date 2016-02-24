% restituisce la matrice contenente tutte le feature delle immagini (primo classificatore)
function matrix = FeaturesFirstClassifier (labelsPath, imagesPath)

addpath('../Utility');
labelsMatrix = csvread(labelsPath);
labelsMatrix = simplifyMatrix(labelsMatrix);
[numImage, num_labels] = size(labelsMatrix);
%For every image there is left feet and right feet
num_features=6;
matrix=zeros(numImage*2,3+num_features,'double');
indexMatrix = 1;
for i=1:numImage
	fullPath=strcat(imagesPath,int2str(labelsMatrix(i,1)),'_cleared_bn_left_rotated.png');
	[lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure,indexPressure] = RegionOfInterest(fullPath);
	matrix(indexMatrix,1)=labelsMatrix(i,1);
    %0 for left, 1 for right
	matrix(indexMatrix,2)=0;
	matrix(indexMatrix,3)=lengthMinIstmo;
	matrix(indexMatrix,4)=lengthMaxAvampiede;
	matrix(indexMatrix,5)=lengthMediaIstmo;
	matrix(indexMatrix,6)=indicePatologia;
	matrix(indexMatrix,7)=mediumPressure;
    matrix(indexMatrix,8)=indexPressure;
	matrix(indexMatrix,9)=convert_label(labelsMatrix(i,:), true,false);
	indexMatrix = indexMatrix + 1;
	fullPath=strcat(imagesPath,int2str(labelsMatrix(i,1)),'_cleared_bn_right_rotated.png');
	[lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(fullPath);
	matrix(indexMatrix,1)=labelsMatrix(i,1);
	matrix(indexMatrix,2)=1;
	matrix(indexMatrix,3)=lengthMinIstmo;
	matrix(indexMatrix,4)=lengthMaxAvampiede;
	matrix(indexMatrix,5)=lengthMediaIstmo;
	matrix(indexMatrix,6)=indicePatologia;
	matrix(indexMatrix,7)=mediumPressure;
    matrix(indexMatrix,8)=indexPressure;
	matrix(indexMatrix,9)=convert_label(labelsMatrix(i,:),false,false);
	indexMatrix = indexMatrix + 1;
end

firstFeatureIndex = 3;
lastFeatureIndex = 3 + num_features - 1;

matrix(:, firstFeatureIndex:lastFeatureIndex) = StatisticalNormaliz(matrix(:, firstFeatureIndex:lastFeatureIndex), 'standard');

end

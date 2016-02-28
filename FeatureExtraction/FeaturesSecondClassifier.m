% restituisce la matrice contenente tutte le feature delle immagini (secondo classificatore)
function matrix = FeaturesSecondClassifier (labelsPath, imagesPath)

addpath('../Utility');
labelsMatrix = csvread(labelsPath);
labelsMatrix = simplifyMatrix(labelsMatrix);
[numImage, num_labels] = size(labelsMatrix);
%For every image there is left feet and right feet
num_features=4;
matrix=zeros(numImage*2,3+num_features,'double');
indexMatrix = 1;
for i=1:numImage
	fullPath=strcat(imagesPath,int2str(labelsMatrix(i,1)),'_cleared_bn_left_rotated.png');
	[diffPosition,approssimated,leftDistance,rightDistance] = valgoVaro (fullPath);
	matrix(indexMatrix,1)=labelsMatrix(i,1);
    %0 for left, 1 for right
	matrix(indexMatrix,2)=0;
	matrix(indexMatrix,3)=diffPosition;
    matrix(indexMatrix,4)=approssimated;
    matrix(indexMatrix,5)=leftDistance;
    matrix(indexMatrix,6)=rightDistance;
	matrix(indexMatrix,7)=convert_label(labelsMatrix(i,:), true,true);
	indexMatrix = indexMatrix + 1;
	fullPath=strcat(imagesPath,int2str(labelsMatrix(i,1)),'_cleared_bn_right_rotated.png');
	[diffPosition,approssimated,leftDistance,rightDistance] = valgoVaro (fullPath);
	matrix(indexMatrix,1)=labelsMatrix(i,1);
	matrix(indexMatrix,2)=1;
	matrix(indexMatrix,3)=diffPosition;
    matrix(indexMatrix,4)=approssimated;
	matrix(indexMatrix,5)=leftDistance;
    matrix(indexMatrix,6)=rightDistance;
	matrix(indexMatrix,7)=convert_label(labelsMatrix(i,:), false,true);
	indexMatrix = indexMatrix + 1;
end

firstFeatureIndex = 3;
lastFeatureIndex = firstFeatureIndex + num_features - 1;

matrix(:, firstFeatureIndex:lastFeatureIndex) = StatisticalNormaliz(matrix(:, firstFeatureIndex:lastFeatureIndex), 'standard');

end

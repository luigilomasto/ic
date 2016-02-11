% restituisce la matrice contenente tutte le feature delle immagini (primo classificatore)
function matrix = FeaturesFirstClassifier (startImage, endImage)
numImage=int32(range(startImage, endImage));
%For every image there is left feet and right feet
matrix=zeros(numImage*2,5,'double');
path='../DatiPreprocessed/';
indexMatrix = 1;
for i=startImage:endImage
  fullPath=strcat(path,num2str(i),'_cleared_bn_left_rotated.png');
  try
     [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(path);
     matrix(indexMatrix,1)=lengthMinIstmo;
     matrix(indexMatrix,2)=lengthMaxAvampiede;
     matrix(indexMatrix,3)=lengthMediaIstmo;
     matrix(indexMatrix,4)=indicePatologia;
     matrix(indexMatrix,5)=mediumPressure;
  catch exception
     matrix(indexMatrix,:)=0;
  end
  fullPathpath=strcat(path,num2str(i),'_cleared_bn_right_rotated.png');
  indexMatrix += 1;
  try
     [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(path);
     matrix(indexMatrix,1)=lengthMinIstmo;
     matrix(indexMatrix,2)=lengthMaxAvampiede;
     matrix(indexMatrix,3)=lengthMediaIstmo;
     matrix(indexMatrix,4)=indicePatologia;
     matrix(indexMatrix,5)=mediumPressure;
  catch exception
     matrix(indexMatrix,:)=0;
  end
  indexMatrix += 1;
end

end

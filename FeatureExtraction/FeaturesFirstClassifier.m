% restituisce la matrice contenente tutte le feature delle immagini (primo classificatore)
function matrix = FeaturesFirstClassifier (startImage, endImage)
numImage=int32(range(startImage:endImage));
%For every image there is left feet and right feet
matrix=zeros(numImage*2,5,'double');
path='/home/marco/DatiPreprocessed/';
indexMatrix = 1;
for i=startImage:endImage
  fullPath=strcat(path,num2str(i),'_cleared_bn_left_rotated.png');
  if exist(fullPath, 'file') == 2
     [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(fullPath);
     matrix(indexMatrix,1)=lengthMinIstmo;
     matrix(indexMatrix,2)=lengthMaxAvampiede;
     matrix(indexMatrix,3)=lengthMediaIstmo;
     matrix(indexMatrix,4)=indicePatologia;
     matrix(indexMatrix,5)=mediumPressure;
     indexMatrix = indexMatrix + 1;
  end
  fullPath=strcat(path,num2str(i),'_cleared_bn_right_rotated.png');
  if exist(fullPath, 'file') == 2
     [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(fullPath);
     matrix(indexMatrix,1)=lengthMinIstmo;
     matrix(indexMatrix,2)=lengthMaxAvampiede;
     matrix(indexMatrix,3)=lengthMediaIstmo;
     matrix(indexMatrix,4)=indicePatologia;
     matrix(indexMatrix,5)=mediumPressure;
     indexMatrix = indexMatrix + 1;
  end
end

end

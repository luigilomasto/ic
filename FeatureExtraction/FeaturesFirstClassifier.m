% restituisce la matrice contenente tutte le feature delle immagini (primo classificatore)

function matrix = FeaturesFirstClassifier (numImage)

matrix=zeros(numImage*2,7,'double');
path='../DatiPreprocessed/';

for i=1:numImage
path=strcat(path,num2str(i-1),'_cleared_bn_left_rotated.png');
j=i*2-1;
try
   [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(path);
   matrix(j,1)=lengthMinIstmo;
   matrix(j,2)=lengthMaxAvampiede;
   matrix(j,3)=lengthMediaIstmo;
   matrix(j,4)=indicePatologia;
   matrix(j,5)=mediumPressure;
   
catch exception
   matrix(j,:)=0;
end
path='../DatiPreprocessed/';
path=strcat(path,num2str(i-1),'_cleared_bn_right_rotated.png');
try
   [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,indicePatologia,mediumPressure] = RegionOfInterest(path);
   matrix(j+1,1)=lengthMinIstmo;
   matrix(j+1,2)=lengthMaxAvampiede;
   matrix(j+1,3)=lengthMediaIstmo;
   matrix(j+1,4)=indicePatologia;
   matrix(j+1,5)=mediumPressure;

catch exception
   matrix(j+1,:)=0;
end



path='../DatiPreprocessed/';
end

end

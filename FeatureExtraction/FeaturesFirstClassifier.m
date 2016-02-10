% restituisce la matrice contenente tutte le feature delle immagini (primo classificatore)

function matrix = FeaturesFirstClassifier (numImage)

matrix=zeros(numImage,5,'double');
path='../DatiPreprocessed/';

for i=1:numImage
path=strcat(path,num2str(i-1),'_cleared_bn_left_rotated.png');
try
   [lengthMinIstmo,lengthMaxAvampiede,lengthMediaIstmo,mediumPressure] = RegionOfInterest(path);
   matrix(i,1)=lengthMinIstmo;
   matrix(i,2)=lengthMaxAvampiede;
   matrix(i,3)=lengthMediaIstmo;
   matrix(i,4)=mediumPressure;
catch exception
   matrix(i,:)=0;
end
path='../DatiPreprocessed/';
end
end

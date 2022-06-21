% Generate ImgDatastore file with a ten-fold cross-validation data 
tic
Path = fullfile(pwd,'\Nine_Type');
Mdata = imageDatastore(Path,'IncludeSubfolders',true,'LabelSource','foldernames');

[Data1,Data2,Data3,Data4,Data5,Data6,Data7,Data8,Data9,Data10] = splitEachLabel(Mdata,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,'randomize');

%
%
valData = Data1;
trainData = [Data2.Files;Data3.Files;Data4.Files;Data5.Files;Data6.Files;Data7.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data2.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(1).trainData = trainData;
tenCrossData(1).valData = valData;

%
valData = Data2;
trainData = [Data1.Files;Data3.Files;Data4.Files;Data5.Files;Data6.Files;Data7.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(2).trainData = trainData;
tenCrossData(2).valData = valData;

%
valData = Data3;
trainData = [Data1.Files;Data2.Files;Data4.Files;Data5.Files;Data6.Files;Data7.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(3).trainData = trainData;
tenCrossData(3).valData = valData;

%
valData = Data4;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data5.Files;Data6.Files;Data7.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(4).trainData = trainData;
tenCrossData(4).valData = valData;

%
valData = Data5;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data4.Files;Data6.Files;Data7.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data4.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(5).trainData = trainData;
tenCrossData(5).valData = valData;

%
valData = Data6;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data4.Files;Data5.Files;Data7.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data7.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(6).trainData = trainData;
tenCrossData(6).valData = valData;

%
valData = Data7;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data4.Files;Data5.Files;Data6.Files;Data8.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data8.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(7).trainData = trainData;
tenCrossData(7).valData = valData;

%
valData = Data8;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data4.Files;Data5.Files;Data6.Files;Data7.Files;Data9.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data9.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(8).trainData = trainData;
tenCrossData(8).valData = valData;

%
valData = Data9;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data4.Files;Data5.Files;Data6.Files;Data7.Files;Data8.Files;Data10.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data10.Labels];
trainData.Labels = trainLabels;
tenCrossData(9).trainData = trainData;
tenCrossData(9).valData = valData;

%
valData = Data10;
trainData = [Data1.Files;Data2.Files;Data3.Files;Data4.Files;Data5.Files;Data6.Files;Data7.Files;Data8.Files;Data9.Files];
trainData = imageDatastore(trainData);
trainLabels = [Data1.Labels;Data2.Labels;Data3.Labels;Data4.Labels;Data5.Labels;Data6.Labels;Data7.Labels;Data8.Labels;Data9.Labels];
trainData.Labels = trainLabels;
tenCrossData(10).trainData = trainData;
tenCrossData(10).valData = valData;
save('tenCrossData53925.mat','tenCrossData');
toc


clear
clc

%Generate tenCrossData53925.mat
tenCrossData53925      %Generate  ImgDatastore file   time:About 511 seconds

%Generate tenCrossGrayData.mat
% tenCrossGrayData53925  %Generate the imgdatastore file corresponding to the wafer image after gray and median filtering time:About 628 seconds

tic
load('tenCrossData53925');
load('tenCrossGrayData');

experimentData = 1;  %Use original wafer map as input of CNN
% experimentData = 2;    %Use the wafer Use the wafer after graying and median filtering as the input of CNN

imageSize = 64;

MaxEpochs = 10;
classifyMiniBatchSize = 50; 
optionsMiniBatchSize = 20; 
InitialLearnRate = 0.0005;

setSize = 53925; 
NetName = 'layer_conv19_';
tag = strcat(NetName,num2str(setSize));


[dcnnlayers] = layer_conv19(imageSize,imageSize);

%% 
%Create the training options. Set the maximum number of epochs at 20, and start the training with an initial learning rate of 0.001.
options = trainingOptions('sgdm','MaxEpochs',MaxEpochs,...
    'MiniBatchSize',optionsMiniBatchSize,...
	'InitialLearnRate',InitialLearnRate,...
    'ValidationFrequency',30,...    
      'Verbose',true,...
         'Plots','training-progress');
setValueTime = toc
    

%% Use original wafer map as input of CNN
if experimentData == 1
    for i = 1:10
        trainData =tenCrossGrayData(i).trainData;
        valData =tenCrossGrayData(i).valData;
        setDataTime = toc-setValueTime
        
        mynet = trainNetwork(trainData,dcnnlayers,options);%Training network
        trainNetTime = toc-setValueTime-setDataTime
        
        YTrain = classify(mynet,trainData, 'MiniBatchSize',classifyMiniBatchSize);%Training prediction
        trainClassifyTime = toc-setValueTime-setDataTime-trainNetTime
        
        [trainAccuracy,trainSpecificity,trainPrecision,trainRecall,trainF1score] ...
            = pingGu_confusion(YTrain,trainData.Labels,strcat('tenGrayCrossTrain_',num2str(i)),tag);
        hold on
    
        YTest = classify(mynet,valData, 'MiniBatchSize',classifyMiniBatchSize);
        TestClassifyTime = toc-setValueTime-setDataTime-trainNetTime-trainClassifyTime
        
        [testAccuracy,testSpecificity,testPrecision,testRecall,testF1score] ...
            = pingGu_confusion(YTest,valData.Labels,strcat('tenGrayCrossTest',num2str(i)),tag);   
        
        endTime = toc
        
    %Save data
    tenCrossGrayDataResult(i).NetName = NetName;
    tenCrossGrayDataResult(i).InitialLearnRate = InitialLearnRate;
    tenCrossGrayDataResult(i).imageSize = imageSize;
    tenCrossGrayDataResult(i).trainData = trainData;
    tenCrossGrayDataResult(i).valData = valData;
    tenCrossGrayDataResult(i).mynet = mynet;
    tenCrossGrayDataResult(i).optionsMaxEpochs = MaxEpochs;
    tenCrossGrayDataResult(i).optionsMiniBatchSize = optionsMiniBatchSize;
    tenCrossGrayDataResult(i).optionsInitialLearnRate = InitialLearnRate;
    tenCrossGrayDataResult(i).trainNetTime = trainNetTime;
    tenCrossGrayDataResult(i).classifyMiniBatchSize = classifyMiniBatchSize;
    
    tenCrossGrayDataResult(i).trainClassifyTime = trainClassifyTime;
    tenCrossGrayDataResult(i).trainAccuracy = trainAccuracy;
    tenCrossGrayDataResult(i).trainSpecificity = trainSpecificity; 
    tenCrossGrayDataResult(i).trainPrecision = trainPrecision;
    tenCrossGrayDataResult(i).trainRecall = trainRecall; 
    tenCrossGrayDataResult(i).trainScore = trainF1score;
    tenCrossGrayDataResult(i).trainPredictLabels = YTrain;
    tenCrossGrayDataResult(i).traintargerLabels = cellstr(trainData.Labels);
    tenCrossGrayDataResult(i).endTime = endTime;

    tenCrossGrayDataResult(i).TestClassifyTime = TestClassifyTime;
    tenCrossGrayDataResult(i).TestAccuracy = testAccuracy;
    tenCrossGrayDataResult(i).TestSpecificity = testSpecificity; 
    tenCrossGrayDataResult(i).TestPrecision = testPrecision;
    tenCrossGrayDataResult(i).TestRecall = testRecall; 
    tenCrossGrayDataResult(i).TestScore = testF1score;
    tenCrossGrayDataResult(i).TestPredictLabels = YTest;
    tenCrossGrayDataResult(i).TesttargerLabels = cellstr(valData.Labels);    
    
    save('tenCrossGratDataResult.mat','tenCrossGrayDataResult');
    end
         
%% Use the wafer Use the wafer after graying and median filtering as the input of CNN
elseif experimentData == 2
    for i = 1:10
        trainData =tenCrossData(i).trainData;
        valData =tenCrossData(i).valData;
        setDataTime = toc-setValueTime
        
        mynet = trainNetwork(trainData,dcnnlayers,options);
        trainNetTime = toc-setValueTime-setDataTime
        
        YTrain = classify(mynet,trainData, 'MiniBatchSize',classifyMiniBatchSize);
        trainClassifyTime = toc-setValueTime-setDataTime-trainNetTime
        
        [trainAccuracy,trainSpecificity,trainPrecision,trainRecall,trainF1score] ...
            = pingGu_confusion(YTrain,trainData.Labels,strcat('tenCrossTrain_',num2str(i)),tag);
        hold on
    
        YTest = classify(mynet,valData, 'MiniBatchSize',classifyMiniBatchSize);
        TestClassifyTime = toc-setValueTime-setDataTime-trainNetTime-trainClassifyTime
        
        [testAccuracy,testSpecificity,testPrecision,testRecall,testF1score] ...
            = pingGu_confusion(YTest,valData.Labels,strcat('tenCrossTest',num2str(i)),tag);   
        
        endTime = toc
        
    %Save data
    tenCrossDataResult(i).NetName = NetName;
    tenCrossDataResult(i).InitialLearnRate = InitialLearnRate;
    tenCrossDataResult(i).imageSize = imageSize;
    tenCrossDataResult(i).trainData = trainData;
    tenCrossDataResult(i).valData = valData;
    tenCrossDataResult(i).mynet = mynet;
    tenCrossDataResult(i).optionsMaxEpochs = MaxEpochs;
    tenCrossDataResult(i).optionsMiniBatchSize = optionsMiniBatchSize;
    tenCrossDataResult(i).optionsInitialLearnRate = InitialLearnRate;
    tenCrossDataResult(i).trainNetTime = trainNetTime;
    tenCrossDataResult(i).classifyMiniBatchSize = classifyMiniBatchSize;
    
    tenCrossDataResult(i).trainClassifyTime = trainClassifyTime;
    tenCrossDataResult(i).trainAccuracy = trainAccuracy;
    tenCrossDataResult(i).trainSpecificity = trainSpecificity; 
    tenCrossDataResult(i).trainPrecision = trainPrecision;
    tenCrossDataResult(i).trainRecall = trainRecall; 
    tenCrossDataResult(i).trainScore = trainF1score;
    tenCrossDataResult(i).trainPredictLabels = YTrain;
    tenCrossDataResult(i).traintargerLabels = cellstr(trainData.Labels);
    tenCrossDataResult(i).endTime = endTime;

    tenCrossDataResult(i).TestClassifyTime = TestClassifyTime;
    tenCrossDataResult(i).TestAccuracy = testAccuracy;
    tenCrossDataResult(i).TestSpecificity = testSpecificity; 
    tenCrossDataResult(i).TestPrecision = testPrecision;
    tenCrossDataResult(i).TestRecall = testRecall; 
    tenCrossDataResult(i).TestScore = testF1score;
    tenCrossDataResult(i).TestPredictLabels = YTest;
    tenCrossDataResult(i).TesttargerLabels = cellstr(valData.Labels);    
    
    save('tenCrossDataResult.mat','tenCrossDataResult');
    
    end
    
end
    

  



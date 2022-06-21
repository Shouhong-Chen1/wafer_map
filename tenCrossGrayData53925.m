% Generate ImgDatastore file with a ten-fold cross-validation data after graying and median filtering 
clear
clc
tic
load('tenCrossData53925.mat');

%% Generate ImgDatastore file£¬Paths of ten training sets corresponding to the original graph
for i = 1:10
    n = size((tenCrossData(i).trainData.Files),1);
    trainDataName = split(tenCrossData(i).trainData.Files,'\');

    for j = 1:n
        trainDataName{j,3} =  strrep(trainDataName{j,3},'Nine_Type','per_0');
        if strcmp(trainDataName{j,4},'Local') == 1
            trainDataName{j,5} = strrep(trainDataName{j,5},'Loc','Local'); 
        end
        if strcmp(trainDataName{j,4},'Center') == 1
            num = '(1) ';
        elseif strcmp(trainDataName{j,4},'Donut') == 1
            num = '(2) ';
        elseif strcmp(trainDataName{j,4},'Edge-loc') == 1
            num = '(3) ';
        elseif strcmp(trainDataName{j,4},'Edge-ring') == 1
            num = '(4) ';
        elseif strcmp(trainDataName{j,4},'Local') == 1
            num = '(5) ';
        elseif strcmp(trainDataName{j,4},'Near-full') == 1
            num = '(6) ';
        elseif strcmp(trainDataName{j,4},'None') == 1
            num = '(9) ';
        elseif strcmp(trainDataName{j,4},'Random') == 1
            num = '(7) ';
        elseif strcmp(trainDataName{j,4},'Scratch') == 1
            num = '(8) ';
        end 
        grayTrainDataPath{j,1} = [trainDataName{j,1},'\',trainDataName{j,2},'\',trainDataName{j,3},'\',num,trainDataName{j,5}];
    end
        trainGrayData.File = grayTrainDataPath; 
 
    trainData = imageDatastore(trainGrayData.File);
    trainData.Labels = tenCrossData(i).trainData.Labels;
    tenCrossGrayData(i).trainData = trainData; 

    clear grayTrainDataPath

    perTrainData = toc
end

    
%% Generate ImgDatastore file£¬Paths of ten test sets corresponding to the original graph
for i = 1:10
    n = size((tenCrossData(i).valData.Files),1);
    valDataName = split(tenCrossData(i).valData.Files,'\');

    for j = 1:n
        valDataName{j,3} =  strrep(valDataName{j,3},'Nine_Type','per_0');
        if strcmp(valDataName{j,4},'Local') == 1
            valDataName{j,5} = strrep(valDataName{j,5},'Loc','Local'); 
        end
        if strcmp(valDataName{j,4},'Center') == 1
            num = '(1) ';
        elseif strcmp(valDataName{j,4},'Donut') == 1
            num = '(2) ';
        elseif strcmp(valDataName{j,4},'Edge-loc') == 1
            num = '(3) ';
        elseif strcmp(valDataName{j,4},'Edge-ring') == 1
            num = '(4) ';
        elseif strcmp(valDataName{j,4},'Local') == 1
            num = '(5) ';
        elseif strcmp(valDataName{j,4},'Near-full') == 1
            num = '(6) ';
        elseif strcmp(valDataName{j,4},'None') == 1
            num = '(9) ';
        elseif strcmp(valDataName{j,4},'Random') == 1
            num = '(7) ';
        elseif strcmp(valDataName{j,4},'Scratch') == 1
            num = '(8) ';
        end 
        grayValDataPath{j,1} = [valDataName{j,1},'\',valDataName{j,2},'\',valDataName{j,3},'\',num,valDataName{j,5}];
    end
        valGrayData.File = grayValDataPath; 
 
    valData = imageDatastore(valGrayData.File);
    valData.Labels = tenCrossData(i).valData.Labels;
    tenCrossGrayData(i).valData = valData; 
    clear grayValDataPath
    end
    endTime = toc   
    
save('tenCrossGrayData.mat','tenCrossGrayData');





% Generate ImgDatastore file with a ten-fold cross-validation data after graying and median filtering  
clear
clc
tic
load('tenCrossData53925.mat');

%% Generate ImgDatastore file£¬Paths of ten training sets corresponding to the original graph
for i = 1:10
    n = size((tenCrossData(i).trainData.Files),1);
    trainDataName = tenCrossData(i).trainData.Files;

    for j = 1:n
           trainDataName{j,1} =  strrep(trainDataName{j,1},'Nine_Type','per_0');
        if ~isempty(findstr(trainDataName{j,1},'\Center\'))
            trainDataName{j,1} = strrep(trainDataName{j,1},'\Center\Center_','\(1) Center_');
          elseif ~isempty(findstr(trainDataName{j,1},'\Donut\'))
            trainDataName{j,1} = strrep(trainDataName{j,1},'\Donut\Donut_','\(2) Donut_');
          elseif  ~isempty(findstr(trainDataName{j,1},'\Edge-loc\'))
            trainDataName{j,1} = strrep(trainDataName{j,1},'\Edge-loc\Edge-Loc_','\(3) Edge-Loc_');
          elseif ~isempty(findstr(trainDataName{j,1},'\Edge-ring\'))
            trainDataName{j,1} = strrep(trainDataName{j,1},'\Edge-ring\Edge-Ring_','\(4) Edge-Ring_');
          elseif ~isempty(findstr(trainDataName{j,1},'\Local\'))
            trainDataName{j,1} = strrep(trainDataName{j,1},'\Local\Loc_','\(5) Local_');
          elseif ~isempty(findstr(trainDataName{j,1},'\Near-full\'))
              trainDataName{j,1} = strrep(trainDataName{j,1},'\Near-full\Near-full_','\(6) Near-full_');
          elseif ~isempty(findstr(trainDataName{j,1},'\None\'))
              trainDataName{j,1} = strrep(trainDataName{j,1},'\None\None_','\(9) None_');
          elseif ~isempty(findstr(trainDataName{j,1},'\Random\'))
             trainDataName{j,1} = strrep(trainDataName{j,1},'\Random\Random_','\(7) Random_');
          elseif ~isempty(findstr(trainDataName{j,1},'\Scratch\'))
             trainDataName{j,1} = strrep(trainDataName{j,1},'\Scratch\Scratch_','\(8) Scratch_');
        end 
        grayTrainDataPath{j,1} = trainDataName{j,1};
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
    valDataName = tenCrossData(i).valData.Files;
    for j = 1:n
           valDataName{j,1} =  strrep(valDataName{j,1},'Nine_Type','per_0');
        if ~isempty(findstr(valDataName{j,1},'\Center\'))
            valDataName{j,1} = strrep(valDataName{j,1},'\Center\Center_','\(1) Center_');
          elseif ~isempty(findstr(valDataName{j,1},'\Donut\'))
            valDataName{j,1} = strrep(valDataName{j,1},'\Donut\Donut_','\(2) Donut_');
          elseif  ~isempty(findstr(valDataName{j,1},'\Edge-loc\'))
            valDataName{j,1} = strrep(valDataName{j,1},'\Edge-loc\Edge-Loc_','\(3) Edge-Loc_');
          elseif ~isempty(findstr(valDataName{j,1},'\Edge-ring\'))
            valDataName{j,1} = strrep(valDataName{j,1},'\Edge-ring\Edge-Ring_','\(4) Edge-Ring_');
          elseif ~isempty(findstr(valDataName{j,1},'\Local\'))
            valDataName{j,1} = strrep(valDataName{j,1},'\Local\Loc_','\(5) Local_');
          elseif ~isempty(findstr(valDataName{j,1},'\Near-full\'))
              valDataName{j,1} = strrep(valDataName{j,1},'\Near-full\Near-full_','\(6) Near-full_');
          elseif ~isempty(findstr(valDataName{j,1},'\None\'))
              valDataName{j,1} = strrep(valDataName{j,1},'\None\None_','\(9) None_');
          elseif ~isempty(findstr(valDataName{j,1},'\Random\'))
             valDataName{j,1} = strrep(valDataName{j,1},'\Random\Random_','\(7) Random_');
          elseif ~isempty(findstr(valDataName{j,1},'\Scratch\'))
             valDataName{j,1} = strrep(valDataName{j,1},'\Scratch\Scratch_','\(8) Scratch_');
        end 
        grayValDataPath{j,1} = valDataName{j,1};
    end 
        valGrayData.File = grayValDataPath; 
 
    valData = imageDatastore(valGrayData.File);
    valData.Labels = tenCrossData(i).valData.Labels;
    tenCrossGrayData(i).valData = valData; 
    clear grayValDataPath
    end
    endTime = toc   
    
save('tenCrossGrayData.mat','tenCrossGrayData');





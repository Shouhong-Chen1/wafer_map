

%use the method of decision-level information entropy fusion  to realize the final classification of the wafer map
tic

clear
clc
load('tenCrossDataResult');
load('tenCrossGrayDataResult');

setSize = 53925; %Data set size
NetName = 'layer_conv19_';
tag = strcat(NetName,num2str(setSize));

Labels = {'Center','Donut','Edge-loc','Edge-ring','Local','Near-full','None','Random','Scratch'};

for t = 1:10
    net1 = tenCrossDataResult(t).mynet;
    net2 = tenCrossGrayDataResult(t).mynet;
    
    %% Training set
    oriTrainData = tenCrossDataResult(t).trainData; 
    grayTrainData = tenCrossGrayDataResult(t).trainData;
    
    P1 = predict(net1,oriTrainData);  %  probability output Matrix P of Original wafer map
    P2 = predict(net2,grayTrainData); % probability output Matrix P after gray and median filtering
    
    for i = 1:size(P1,1)
        A(i).P(1,:) = P1(i,:);
        A(i).P(2,:) = P2(i,:);
        
        % Input sample information entropy in each network
        dim1 = size((A(i).P),1); %two CNN
        dim2 = size((A(i).P),2); %The probability category number dimension
        for i1 = 1:dim1
            y = 0;
            for j = 1:dim2
                y = y + (-A(i).P(i1,j)*log2(A(i).P(i1,j)));
            end
            H(i1) = y;
            clear y
        end
        A(i).H = H; 
        
        % Each network weight
        for k = 1:size(A(i).H,2)
            W(k) = exp(-A(i).H(k))/(sum(exp(-A(i).H(:))));
        end
        A(i).W = W;
        
        % New Probability Output Matrix
        for k1 = 1:size(A(i).P,1)
            Pnew(k1,:) = A(i).W(k1)*A(i).P(k1,:);
        end
        
        % Weighted summation, decision fusion result
        [maxnum,index] = max(sum(Pnew));
        trainLabel{i,1}  = Labels{1,index};
        
    end
    
    trL = categorical(trainLabel);
    clear trainLabel
    clear A
    
    
    %% Test set
    oriValData = tenCrossDataResult(t).valData;
    grayValData = tenCrossGrayDataResult(t).valData;
    
    P3 = predict(net1,oriValData);  % 
    P4 = predict(net2,grayValData); % 
    
    for i = 1:size(P3,1)
        B(i).P(1,:) = P3(i,:);
        B(i).P(2,:) = P4(i,:);
        
        %  
        dim1 = size((B(i).P),1); %
        dim2 = size((B(i).P),2); %
        for i1 = 1:dim1
            y = 0;
            for j = 1:dim2
                y = y + (-B(i).P(i1,j)*log2(B(i).P(i1,j)));
            end
            H(i1) = y;
            clear y
        end
        B(i).H = H;
        
        % 
        for k = 1:size(B(i).H,2)
            W(k) = exp(-B(i).H(k))/(sum(exp(-B(i).H(:))));
        end
        B(i).W = W;
        
        % 
        for k1 = 1:size(B(i).P,1)
            Pnew(k1,:) = B(i).W(k1)*B(i).P(k1,:);
        end
        
        % 
        [maxnum,index] = max(sum(Pnew));
        valLabel{i,1}  = Labels{1,index};
        
    end
    
    teL = categorical(valLabel);
    clear valLabel
    
    
    [trAccuracy,trSpecificity,trPrecision,trRecall,trF1Score] = pingGu_confusion(trL,oriTrainData.Labels,strcat('Train_',num2str(t)),tag);
    hold on
    [teAccuracy,teSpecificity,tePrecision,teRecall,teF1Score] = pingGu_confusion(teL,oriValData.Labels,strcat('Test_',num2str(t)),tag);
    
    
    %Save Data
    MulSource_Result(t).NetName = tenCrossDataResult.NetName;
    MulSource_Result(t).imageSize = tenCrossDataResult.imageSize;
    MulSource_Result(t).oritrainData = oriTrainData;
    MulSource_Result(t).grayTrainData = grayTrainData;
    MulSource_Result(t).oriValData = oriValData;
    MulSource_Result(t).grayValData = grayValData;
    
    MulSource_Result(t).trL = trL;
    MulSource_Result(t).trAccuracy = trAccuracy;
    MulSource_Result(t).trSpecificity = trSpecificity;
    MulSource_Result(t).trPrecision = trPrecision;
    MulSource_Result(t).trRecall = trRecall;
    MulSource_Result(t).trF1Score = trF1Score;
    
    MulSource_Result(t).teL = teL;
    MulSource_Result(t).teAccuracy = teAccuracy;
    MulSource_Result(t).teSpecificity = teSpecificity;
    MulSource_Result(t).tePrecision = tePrecision;
    MulSource_Result(t).teRecall = teRecall;
    MulSource_Result(t).teF1Score = teF1Score;
      
    save('MulSource_Result.mat','MulSource_Result');
    
    toc
    
    
end











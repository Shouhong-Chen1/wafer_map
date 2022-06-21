function [accuracy,specificity,precision,recall,F1score] ...
    = pingGu_confusion(predictLabel,targetLabel,confusionTitle,NetName)
%% pingGu_confusion 评估分类结果
%% 函数说明
%% 输入：
%       predictLabel 预测标签
%       targerLabel 原标签
%       confusionTitle 混淆矩阵名
%% 输出：
%       accuracy 分类总准确率
%       specificity 分类特异性
%       precision 分类精确率
%       recall 分类召回率
%       F1score 分类的F1评分
%% ===========================================================================
%% 1.评估
    if length(predictLabel)~=length(targetLabel)
        disp('预测标签与实际标签的输入维度不一致')
    elseif length(unique(targetLabel))~=length(unique(predictLabel))
        disp('预测标签与实际标签的标签类型维度不一致')
    else
        classLabel(:,1) = unique(targetLabel);
        TP = zeros(length(classLabel));
        TN = zeros(length(classLabel));
        FN = zeros(length(classLabel));
        FP = zeros(length(classLabel));
        specificity = zeros(length(classLabel));
        precision = zeros(length(classLabel));
        recall = zeros(length(classLabel));
        F1score = zeros(length(classLabel));
        for i=1:length(classLabel)
            TP(i) = sum((predictLabel == classLabel(i)) & (targetLabel == classLabel(i))); 
            TN(i) = sum((predictLabel ~= classLabel(i)) & (targetLabel ~= classLabel(i)));
            FN(i) = sum((predictLabel ~= classLabel(i)) & (targetLabel == classLabel(i)));
            FP(i) = sum((predictLabel == classLabel(i)) & (targetLabel ~= classLabel(i)));
            specificity(i) = TN(i)/(TN(i)+FN(i));
            precision(i) = TP(i)/(TP(i)+FP(i));
            recall(i) = TP(i)/(TP(i)+FN(i));
            F1score(i) = (2*precision(i)*recall(i))/(precision(i)+recall(i));
        end
        accuracy = sum(predictLabel == targetLabel)/numel(targetLabel);%准确率
    %% 2。作混淆矩阵
        tarLabel = zeros(length(targetLabel),1);
        preLabel = zeros(length(predictLabel),1);
        for i=1:length(classLabel)
            tarLabel(targetLabel==classLabel(i),1) = i;
            preLabel(predictLabel==classLabel(i),1) = i;
        end
        figure();
        ttest = dummyvar(tarLabel)' ;  
        tpredictions = dummyvar(preLabel)';
        plotconfusion(ttest,tpredictions,confusionTitle); %对混淆矩阵做图
        tickLabels = cellstr(unique(targetLabel));
        xticks(1:length(classLabel))
        xticklabels({tickLabels{:}})
        xlabel('Labels');
        yticks(1:length(classLabel))
        yticklabels({tickLabels{:}})
        ylabel('Pridictions');
    end
    fn = strcat(pwd,'\',NetName,'_',confusionTitle,'.png');
    saveas(gcf,fn)
end


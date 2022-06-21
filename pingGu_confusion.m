function [accuracy,specificity,precision,recall,F1score] ...
    = pingGu_confusion(predictLabel,targetLabel,confusionTitle,NetName)
%% pingGu_confusion ����������
%% ����˵��
%% ���룺
%       predictLabel Ԥ���ǩ
%       targerLabel ԭ��ǩ
%       confusionTitle ����������
%% �����
%       accuracy ������׼ȷ��
%       specificity ����������
%       precision ���ྫȷ��
%       recall �����ٻ���
%       F1score �����F1����
%% ===========================================================================
%% 1.����
    if length(predictLabel)~=length(targetLabel)
        disp('Ԥ���ǩ��ʵ�ʱ�ǩ������ά�Ȳ�һ��')
    elseif length(unique(targetLabel))~=length(unique(predictLabel))
        disp('Ԥ���ǩ��ʵ�ʱ�ǩ�ı�ǩ����ά�Ȳ�һ��')
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
        accuracy = sum(predictLabel == targetLabel)/numel(targetLabel);%׼ȷ��
    %% 2������������
        tarLabel = zeros(length(targetLabel),1);
        preLabel = zeros(length(predictLabel),1);
        for i=1:length(classLabel)
            tarLabel(targetLabel==classLabel(i),1) = i;
            preLabel(predictLabel==classLabel(i),1) = i;
        end
        figure();
        ttest = dummyvar(tarLabel)' ;  
        tpredictions = dummyvar(preLabel)';
        plotconfusion(ttest,tpredictions,confusionTitle); %�Ի���������ͼ
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


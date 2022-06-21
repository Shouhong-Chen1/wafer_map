function [dcnnlayers] = layer_conv19(imageSize1,imageSize2)
 
dcnnlayers = [
    imageInputLayer([imageSize1 imageSize2 1])%Input layer

    convolution2dLayer(5,75,'Padding',1)
    batchNormalizationLayer
    reluLayer%relu²ã
    maxPooling2dLayer(2,'Stride',2)%pooling

    convolution2dLayer(5,75,'Padding',1)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(5,75,'Padding',1)
    batchNormalizationLayer
    reluLayer  
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,30,'Padding',1)
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(9)
    softmaxLayer
    classificationLayer];

end
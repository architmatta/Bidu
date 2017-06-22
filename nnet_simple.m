% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by Neural Pattern Recognition app
% Created 01-Apr-2017 17:48:46
%
% This script assumes these variables are defined:
%
%   sound_train - input data.
%   new_output - target data.
function[net, tr, epochs] = nnet_simple(sound_train, final_output)
x = sound_train';
t = final_output';

% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 80;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

net.divideFcn = 'divideind';

trainFile = matfile('trainInd.mat');
valFile = matfile('valInd.mat');
testFile = matfile('testInd.mat');

net.divideParam.trainInd = trainFile.trainInd;
net.divideParam.valInd = valFile.valInd;
net.divideParam.testInd = testFile.testInd;

net.trainParam.lr = 0.0001;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotconfusion(t,y)
%figure, plotroc(t,y)

epochs = tr.epoch(end);

end


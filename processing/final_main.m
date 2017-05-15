%This is the main file to run the whole process

%% Initialization
clear ; close all; clc

fprintf('Step 1 - Calculate Features.\n');
fprintf('Press enter to continue.\n');
fprintf('--------------------------\n');
pause;

[sound_train, train_output] = main();
mean_train = mean(sound_train);
dev_train = std(sound_train);

for i = 1:size(sound_train)
    sound_train(i, :) = (sound_train(i, :)-mean_train(1, :))./dev_train;
end

fprintf('Features calculated.\n');
fprintf('Step 2 - Train the neural network classifier.\n');
fprintf('Press enter to continue.\n');
fprintf('--------------------------\n');
pause;

net = nnet_simple(sound_train, train_output);

fprintf('Network trained.\n');
temp = 1;
while(temp>0)
    fprintf('Now enter file path you want to test it on.\n');
    audiofile = input('File Path >>', 's');
    
    [output, tym] = full_sound_file(audiofile, net, mean_train, dev_train);
    fprintf('The tym array contains time at which horn is present.\n');
    temp = input('Want to test another? Enter a positive number. >>', 's');
    temp = str2double(temp);
end
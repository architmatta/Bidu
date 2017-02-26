%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to run the whole process
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

[horn_train] = get_horn_data();
[random_train] = get_random_data();
horn_feat = [];
random_feat = [];

%% ==========Part 1: Find Feature and visualize============
for i = 1:size(horn_train) 
    audiofile = horn_train(i, :);
    [sound_data, samp_freq] = audioread(audiofile, 'double');
    sound_data = sound_data(:, 1);
    frame_length = 50;
    frame_shift = 25;
    alpha = 0.97;
    window = @hanning;
    R = [300 5000]; %frequency range
    M = 26; % number of filterbank channels
    N = 20; % number of mfcc
    L = 22; % liftering coefficient
    [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    
    horn_feat = [horn_feat; CC];
end
output = ones(size(horn_feat, 1), 1);

for i = 1:size(random_train) 
    audiofile = random_train(i, :);
    [sound_data, samp_freq] = audioread(audiofile, 'double');
    sound_data = sound_data(:, 1);
    frame_length = 50;
    frame_shift = 25;
    alpha = 0.97;
    window = @hanning;
    R = [300 5000]; %frequency range
    M = 26; % number of filterbank channels
    N = 20; % number of mfcc
    L = 22; % liftering coefficient
    [ CC, FBE, frames ] = mfcc( sound_data, samp_freq, frame_length,...
        frame_shift, alpha, window, R, M, N, L );
    CC = CC';
    
    random_feat = [random_feat; CC];
end
out1= ones(size(horn_feat, 1), 1);
for i = 1:size(random_feat, 1)
    output = [output; 0];
end
sound_train = [horn_feat; random_feat];
%matrix_data = [sound_train output];
%shuffled_data = matrix_data(randperm(size(matrix_data, 1)), :);
%shuffled_data = shuffled_data(~any(isnan(shuffled_data),2),:);
%sound_train = shuffled_data(:, 1:20);
%output = shuffled_data(:, 21);
new_output = [output abs(output-1)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main file to run the whole process
%This file is meant to process the data and find features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
clear ; close all; clc

[sound_train] = get_horn_data();
horn_feat = [];

%% ==========Part 1: Find Feature and visualize============
for i = 1:size(sound_train) 
    audiofile = sound_train(i, :);
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
outcome = ones(size(horn_feat, 1), 1);

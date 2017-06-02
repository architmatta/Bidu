clear all; clc; 
%run the whole process n no.
%frame_length = 50;
%frame_shift = 25;
alpha = 0.97;
window = @hanning;
R = [300 5000]; %frequency range
M = 26; % number of filterbank channels
%N = 20; % number of mfcc
L = 22; % liftering coefficient

set_frame_length = [50; 100; 150; 220; 250];
set_frame_shift = [0.25; 0.50; 0.75; 1.0];
set_mfcc = [5; 8; 10; 12; 15; 18; 20];
set_hidden_node = [0.1; 0.25; 0.50; 0.75; 1.0];

for i = 1:length(set_hidden_node)
    frame_length = set_frame_length(i);
    for j = 1:length(set_frame_shift)
        frame_shift = floor(set_frame_shift(j)*frame_length);
        for k = 1:length(set_mfcc)
            N = set_mfcc(i);
            for l = 1:length(set_hidden_node)
                hidden_node = set_hidden_node(i);
                sheet = strcat('FinalSheets', int2str(i), int2str(j), int2str(k), int2str(l));
                TAG = strcat(int2str(i), int2str(j), int2str(k), int2str(l));
                repeat_same_param(frame_length, frame_shift, alpha, window, R, M, N, L, sheet, hidden_node, TAG);
            end
        end
    end
end

hidden_node = set_hidden_node(i);
    sheet = strcat('HiddenNodes', int2str(i));
    
    
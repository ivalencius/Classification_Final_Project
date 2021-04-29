%% Code for classifying Landsat8 Data
%   Authors: Jose Cuevas & Ilan Valencius

%% Load Pre-Processing Data
load('ROOT_DIR.mat');
%load('Landsat_MetaData.mat');
load('Merged_info.mat');
load('MergeClip_info.mat');
load('hcube_FULL.mat');
load('hcube_CLIPPED.mat');

%% Directory Management
addpath(genpath(ROOT_DIR));

%% Create False Color Image 
false_color1 = colorize(hcube_FULL);
false_color2 = colorize(hcube_CLIPPED);
%% Show extent of data
% imshow(false_color1);
% imshow(false_color2);

%% Determine number of endmembers in study area
numEndmembers_clip = countEndmembersHFC(hcube_CLIPPED);

%% Extract endmembers from study area
%endmembers =  ppi(hcube_CLIPPED,numEndmembers_clip);

%% Plot Endmembers
figure
plot(endmembers)
title(['Number of Endmembers: ' num2str(numEndmembers_clip)])
xlabel('Band Number')
ylabel('Data Values')  
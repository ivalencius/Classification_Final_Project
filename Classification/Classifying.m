%% Code for classifying Landsat8 Data
%   Authors: Jose Cuevas & Ilan Valencius

%% Load Pre-Processing Data
load('ROOT_DIR.mat');
load('CA_SHP.mat');
load('CA_SHP_lon.mat');
load('CA_SHP_lat.mat');
load('proj.mat');
load('bbox.mat');
load('Landsat_MetaData.mat');
save('hcube_FULL.mat','hcube_FULL');
save('hcube_CLIPPED.mat','hcube_CLIPPED');

%% Directory Management
addpath(genpath(ROOT_DIR));

%% Create False Color Image 
false_color = colorize(hcube_Landsat);
%% Show extent of data
imshow(false_color);

%% Extract Endmembers
numEndmembers = countEndmembersHFC(hcube_CLIPPED);
endmembers =  nfindr(hcube_CLIPPED,numEndmembers);

%% Plot Endmembers
figure
plot(endmembers)
title(['Number of Endmembers: ' num2str(numEndmembers)])
xlabel('Band Number')
ylabel('Data Values')  
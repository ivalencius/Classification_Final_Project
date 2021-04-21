%% Code for loading/preprocessing image classificationd data
%   Authors: Jose Cuevas & Ilan Valencius

%% Directory Management - Change as needed
ROOT_DIR = "C:\Users\ilanv\Dropbox\Year_2\Env_Data_Exploration_And_Analysis\Classification_Final_Project";
addpath(genpath(ROOT_DIR));

%% Load CA fire perimeters SHP file + Metadata
CA_SHP = shaperead("Recent_Large_Fire_Perimeters__Last_Five_Years__2015_2019____gt__5000_acres_.shp");
info = shapeinfo("Recent_Large_Fire_Perimeters__Last_Five_Years__2015_2019____gt__5000_acres_.shp");

%% Dereference shapefile -> set project projection
proj = info.CoordinateReferenceSystem;
CA_SHP_x = [CA_SHP.X];
CA_SHP_y = [CA_SHP.Y];
[lat,lon] = projinv(proj,CA_SHP_x,CA_SHP_y);

%% Test Visualization of data
figure (1); clf
geoplot(lat,lon)
hold on
geobasemap('streets')

%% Crop to Area of Interest



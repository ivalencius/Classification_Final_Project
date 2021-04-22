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
CA_SHP_lon = [CA_SHP.X];
CA_SHP_lat = [CA_SHP.Y];
[CA_SHP_lon,CA_SHP_lat] = projinv(proj,CA_SHP_lon,CA_SHP_lat);

%% Test Visualization of data
figure (1); clf
geoplot(CA_SHP_lon,CA_SHP_lat)
hold on
geobasemap('streets')

%% Crop to Area of Interest
bounding_lon = [38, 40];
bounding_lat = [-124, -122];
[bounding_lon,bounding_lat] = projfwd(proj,bounding_lon,bounding_lat);
% bbox = left, bottom, right, top
bbox = [bounding_lon(1), bounding_lat(1); bounding_lon(2), bounding_lat(2)];
% Indexes of shapes outside bounding box
CA_bboxes = CA_SHP.BoundingBox;
[idx_out, ~] = find(CA_bboxes(1) > bbox(1));
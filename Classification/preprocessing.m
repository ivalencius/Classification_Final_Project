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

%% Crop SHP file to Area of Interest
bounding_lon = [-124, -122];
bounding_lat = [38, 40];
bbox = [bounding_lat(1), bounding_lon(1); bounding_lat(2), bounding_lon(2)];

%% Extract and project bounding boxes for polygons onto proper projection
% bbox = left, bottom, right, top
CA_bboxes = {CA_SHP.BoundingBox};
idx_outside = NaN(size(CA_bboxes));
for i = 1:length(CA_bboxes)
   tmp = CA_bboxes{i};
   [tmp(1,1), tmp(1,2)] = projinv(proj, tmp(1,1), tmp(1,2));
   [tmp(2,1), tmp(2,2)] = projinv(proj, tmp(2,1), tmp(2,2));
   if tmp(1,1) < bbox(1,1)
       tmp(1,1) = NaN;
       idx_outside(i) = 1; % Null index found
   end
   if tmp(1,2) < bbox(1,2)
       tmp(1,2) = NaN;
       idx_outside(i) = 1; % Null index found
   end
   if tmp(2,1) > bbox(2,1)
       tmp(2,1) = NaN;
       idx_outside(i) = 1; % Null index found
   end
   if tmp(2,2) > bbox(2,2)
       tmp(2,2) = NaN;
       idx_outside(i) = 1; % Null index found
   end
   CA_bboxes{i} = [tmp(1,1), tmp(1,2), tmp(2,1), tmp(2,2)];
end

idx_outside = find(idx_outside == 1);
CA_SHP(idx_outside) = [];

%% Dereference shapefile -> set project projection
CA_SHP_lon = [CA_SHP.Y];
CA_SHP_lat = [CA_SHP.X];

[CA_SHP_lat,CA_SHP_lon] = projinv(proj,CA_SHP_lat,CA_SHP_lon);
figure (1); clf
geoplot(CA_SHP_lat,CA_SHP_lon)
hold on
geobasemap('streets')

%% Test Visualization of data
figure (1); clf
geoplot(CA_SHP_lat,CA_SHP_lon)
hold on
geobasemap('streets')

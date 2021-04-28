%% Code for loading/preprocessing image classification data
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

%% Dereference shapefile -> map to landsat projection
CA_SHP_lon = [CA_SHP.X];
CA_SHP_lat = [CA_SHP.Y];
[CA_SHP_lon, CA_SHP_lat] = projinv(proj, CA_SHP_lon, CA_SHP_lat);
%[idx, ~] = size(CA_SHP);
%for i = 1:idx
%    [CA_SHP(i).X, CA_SHP(i).Y] = projinv(proj, CA_SHP(i).X, CA_SHP(i).Y);
%end

%% Test Visualization of data
figure (1); clf
geoplot(CA_SHP_lon,CA_SHP_lat)
hold on
geobasemap('streets')

%% Load Landsat Data for Signature Generation
% Parse
%Landsat_Parsed = loadLandSat8V2('LC08_L1TP_045033_20190102_20200830_02_T1_MTL.txt');
Landsat_MetaData = parseLandSat8MetaData('LC08_L1TP_045033_20190102_20200830_02_T1_MTL.txt');
MERGED_tif = readgeoraster("MERGED.tif");
MERGED_info = geotiffinfo("MERGED.tif");
%% Unproject Landsata Data
% merged_data = squeeze(MERGED_tif(:,:,1));
% for i = 1:length(merged_data)
%     for j = 1:length(merged_data(1,:))
%         [x,y] = pix2map(MERGED_info.RefMatrix, merged_data(i),merged_data(i,j));
%         [MERGED_tif, merged_lon] = projinv(MERGED_info, x, y);
%     end
% end
%% Dereference shapefile -> map to landsat projection
CA_SHP_lon = [CA_SHP.X];
CA_SHP_lat = [CA_SHP.Y];
[CA_SHP_lon, CA_SHP_lat] = projinv(MERGED_info, CA_SHP_lon, CA_SHP_lat);
%%
mask = zeros(8246,8110,'logical');
for i = 1:length(CA_SHP)
    rx = CA_SHP(i).X;
    ry = CA_SHP(i).Y;
    mask_temp = inpolygon(merged_X,merged_Y,rx,ry);
    mask = mask | mask_temp;
end
%hcube_FULL = hypercube("MERGED.tif", [0.44 0.48 0.56 0.66 0.87 1.61 2.2 0.59 1.37 10.9 12.01]);
%hcube_CLIPPED = hypercube("MERGED_CLIPPED.tif", [0.44 0.48 0.56 0.66 0.87 1.61 2.2 0.59 1.37 10.9 12.01]);

%% Export Shapefile
shapewrite(CA_SHP, ROOT_DIR + "\California_Fire_Perimeters-shp\Study_area.shp");

%% Export and save necessary variables
save('ROOT_DIR.mat','ROOT_DIR');
save('CA_SHP.mat','CA_SHP');
save('CA_SHP_lon.mat','CA_SHP_lon');
save('CA_SHP_lat.mat','CA_SHP_lat');
save('proj.mat','proj');
save('bbox.mat','bbox');
save('Landsat_MetaData.mat','Landsat_MetaData');
save('hcube_FULL.mat','hcube_FULL');
save('hcube_CLIPPED.mat','hcube_CLIPPED');


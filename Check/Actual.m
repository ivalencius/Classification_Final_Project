%% Importing the result from processing
a = imread('result_burned.png');
histogram(a);
figure(1)
image(a)
%% Convert to Greyscale
greyscale_a = rgb2gray(a);
figure(2)
imshow(greyscale_a)
%% Edit Image: Filter Out All Non-Greys
a_1 = greyscale_a(:,:);
non_grey = find(a_1 ~=86);
a_1(non_grey) = 0;
figure(3)
imshow(a_1)
%% Binarize
BW = imbinarize(a_1);
area_a = bwarea(BW); 
figure(3)
imshow(BW)
%% Importing reference
b= imread('comparison_raster.png');
RefBW=imbinarize(b);
%% resize reference
RefBW_resized=imresize(RefBW,[863,867]);
figure(4)
imshow(RefBW_resized)
%% areas and perimeters
BW_area=bwarea(BW);
BW_perim=bwperim(BW,8);
RefBW_area=bwarea(RefBW_resized);
RefBW_perim=bwperim(RefBW_resized,8);
%% Comparing images:Difference
non_overlap=RefBW_resized-BW;
figure(5)
imshow(non_overlap)
non_overlap_area=bwarea(non_overlap);
%% Comparing images: Overlap
figure(6)
imshowpair(RefBW_perim,BW)
%% Comparing images: Area of id'ed burn (green) covered by magenta
overlap=RefBW_area-non_overlap_area;
% result_area=total_area-non_overlap_area;
% area_diff=(((non_overlap_area-RefBW_area)/non_overlap_area).*100);
figure(8)
histogram(RefBW_resized);
figure(9)
histogram(non_overlap);

%% Separate Objects %%
cc=bwconncomp(RefBW,26);
shape=false(size(RefBW));
shape(cc.PixelIdxList{3}) = true;
figure(9)
imshow(shape)
shape_data=regionprops(cc,'basic');

%% Silly time

for i=1:27
    shape(cc.PixelIdxList{i}) = true;
    shape_{i}=shape;
end






%% graveyard
% shape_areas=[shape_data.Area]';
% shape_id=find(shape_areas(:,:));
% shape_info=NaN([27,2]);
% shape_info(:,1)=shape_areas;
% shape_info(:,2)=shape_id;
% 
% sig_shapes=NaN([7,2]);
% sig_ind=find(shape_info(:,1)>200);
% sig_shapes(:,1)=shape_info(sig_ind,1);
% sig_shapes(:,2)=shape_info(sig_ind,2);

%% Adding color to greyscale
blank_array=zeros([863,867,3]);
blank_array_uin8=uint8(blank_array);
% % RefBW_perim_COLOR=gray2rgb(RefBW_perim);
RefBW_perim_ind=find(RefBW_perim==-1);
% % RefBW_perim(RefBW_perim_ind)=255;
blank_array_uin8(RefBW_perim_ind)=255;
blank_array_uin8(:,:,2)=0;
blank_array_uin8(:,:,3)=0;
figure(7)
imshow(blank_array_uin8)
% Red_ref_peri=cat(1,blank_array_uin8);



 



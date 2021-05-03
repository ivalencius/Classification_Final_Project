%% Importing the Reference Images & Converting RGB to Hex
a = imread('result_burned.png');
histogram(a);
figure(1)
image(a)
%% Edit Image: Red and Black
a_1 = a(:,:,1);
a_2 = a(:,:,2);
a_3 = a(:,:,3);
non_red = find((a_1 ~=255 & ((a_2 > 0)| (a_3 > 0))) | (a_1==255 & ((a_2 > 0)| (a_3 > 0))));
a_1(non_red) = 0;
a_2(non_red) = 0;
a_3(non_red) = 0;
new_image_a = cat(3,a_1,a_2,a_3);
figure(2)
image(new_image_a)
%% Area of Our Image
greyscale_a = rgb2gray(new_image_a);
BW = imbinarize(greyscale_a);
area_a = bwarea(BW); 
figure(3)
imshow(BW)
%% Perimeter of Our Image & It's Area to Determine how much is lost by only included 255,0,0
per = bwperim(greyscale_a,8);
figure(4)
imshow(per)
area_per_a = bwarea(per)
SE = strel('square',2)
increased_size_image = imdilate(per,SE);
figure(5)
imshow(increased_size_image)
area_per_dilated_a = bwarea(increased_size_image);
area_lost = area_per_dilated_a - area_per_a; 
updated_image_a = imfill(increased_size_image);
figure(6)
image(updated_image_a)
%% Comparing Our "New Image" with Ilan and Jose's Image
%b = imread('burned_areas.png');
%histogram(b);
%figure(1)-
% image(b)
% b_1 = b(:,:,1);
% b_2 = b(:,:,2);
% b_3 = b(:,:,3);
% non_red = find((b_1 ~=255 & ((b_2 > 0)| (b_3 > 0))) | (b_1==255 & ((b_2 > 0)| (b_3 > 0))));
% b_1(non_red) = 0;
% b_2(non_red) = 0;
% b_3(non_red) = 0;
% new_image_b = cat(3,b_1,b_2,b_3);
% figure(2)
% image(new_image)
%% Difference between the two images 
%diff = (new_image_a - new_image_b)
%num_zero = sum(diff(:)==0)
%ind_zero = find(diff == 0)
%array_zero = zeros(size(new_image_a)
% 0 = match; nonzero = match
%% Area Difference Between the Two
%pix_wid = 
%pix_length = 
%pix_total = pix_width * pix_length
%percent = (num_zero) / pix_total
%Potentially put area in terms of km
%% Graveyard
%red_ind = find(a(:,:,1) == 255);
%[x,y,z] = find(a(:,:,1) ~= 255);
%new_image_ref = cat(3,a(:,:,1),a(:,:,2),(a:,:,3))

%blank_array_1 = NaN(size(array))
%blank_array_2 = NaN(size(array))
%blank_array_3 = NaN(size(array))

%a_1(non_red_1) = 0;
%a_2(non_red_1) = 0;
%a_3(non_red_1) = 0;
%a_2(non_red_2) = 0;
%a_3(non_red_2) = 0;
%a_2(non_red_3) = 0;
%a_3(non_red_3) = 0;

%non_red_1 = find(a_1 ~= 255);
%non_red_2 = find(0 < a_2 < 255);
%non_red_3 = find(0 < a_3 <255);


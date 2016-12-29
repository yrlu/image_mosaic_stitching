% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
% 

%% or please take a look at demo.m to see how to read data
% load('dataset2.mat', 'dataset');
% 
% %%
% img1 = dataset{1};
% img2 = dataset{2};

%%  
cimg1 = corner_detector(img1);
cimg2 = corner_detector(img2);

[x1, y1, rmax1] = anms(cimg1, 300);
[x2, y2, rmax2] = anms(cimg2, 300);

%% visualize features
visual_feat(img1, cimg1, y1, x1);
visual_feat(img2, cimg2, y2, x2);

%% extract descriptors
[descs1] = feat_desc_geoblur(img1, x1, y1);
[descs2] = feat_desc_geoblur(img2, x2, y2);

%% visualize descriptors
desc = descs1(:,1:100);
desc_mat = zeros(80,80);
for i = 0:99
    x = floor(i / 10);
    y = floor(mod(i, 10));
    [x, y]
    desc_mat(y*8+1 : (y+1)*8, x*8+1: (x+1)*8) = reshape(desc(:,i+1),[8,8]);
end
figure; imagesc(desc_mat); colormap gray; axis image;

%% matching descripts
[match] = feat_match(descs1, descs2);

%% visualize matching
xx1 = x1(match ~= -1);
yy1 = y1(match ~= -1);
xx2 = x2(match(match ~= -1));
yy2 = y2(match(match ~= -1));
showMatchedFeatures(img1, img2, [xx1 yy1], [xx2 yy2], 'montage')


%% ransac
[H, inlier_ind] = ransac_est_homography(xx1, yy1, xx2, yy2, 10);

%% visualize matching after removing outliers
N = numel(xx1);
inliers = zeros(N, 1);
inliers(inlier_ind) = 1;
inliers = logical(inliers);

xx1_inliers = xx1(inliers);
yy1_inliers = yy1(inliers);
xx2_inliers = xx2(inliers);
yy2_inliers = yy2(inliers);
xx1_outliers = xx1(~inliers);
yy1_outliers = yy1(~inliers);
xx2_outliers = xx2(~inliers);
yy2_outliers = yy2(~inliers);

showMatchedFeatures(img1, img2, [xx1_inliers yy1_inliers], [xx2_inliers yy2_inliers], 'montage')

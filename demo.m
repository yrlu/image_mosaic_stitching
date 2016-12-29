% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
% 
%% read and preprocess pictures
% change directory here to test on different datasets 
% 'dataset1/','dataset2/','dataset3/','dataset4/'
directory = 'dataset2/';
files = dir(directory);
files = files(3:end);

N = numel(files);
dataset = {};
cnt = 1;
for i = 1:N
    if files(i).name(1) ~= '.'
    im = imread(strcat(directory,files(i).name));
    im = double(imrotate(imresize(im, [480, 640]), -90))/255;
    dataset{cnt} = im;
    imshow(im);
    drawnow;
    cnt = cnt + 1;
    end
end
% save('dataset2.mat', 'dataset');s

%% load dataset and run
% load('dataset2.mat', 'dataset');

% for dataset 1,2,3 please use the third image as the base image
%   img_m = mymosaic(dataset, 3);
% for dataset 4 please use the second image as the base image
%   img_m = mymosaic(dataset, 2);
% code runs on my local mac less than 5s per image.
img_m = mymosaic(dataset, 3);
imshow(img_m);

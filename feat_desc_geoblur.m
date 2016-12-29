% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
%
% Adaptive Non-Maximal Suppression
% INPUT:    img     double (height)x(width) array (grayscale image) with
%                   values in the range 0-255
%           x       nx1 vector representing the column coordinates of corners
%           y       nx1 vector representing the row coordinates of corners
% OUTPUT:   descs   64xn matrix of double values with column i being the 64
%                   dimensional descriptor computed at location (xi, yi) in im
function [descs] = feat_desc(img, x, y)
tic
DESC_SIZE = 40; % desc size must be divided by 8
SIGMA = 1;
H = size(img, 1);
W = size(img, 2);
N = numel(x);
% convert 2d to 1d  idx = (x-1)*H+y
get_idx = @(x, y) (x-1)*H+y;
descs = zeros(64, N);
for i = 1:N
[xx, yy] = meshgrid(x(i)-DESC_SIZE/2+1:x(i)+DESC_SIZE/2, y(i)-DESC_SIZE/2+1:y(i)+DESC_SIZE/2);
xx(xx<=0) = 1;
xx(xx>W) = W;
yy(yy<=0) = 1;
yy(yy>H) = H;

idx  = get_idx(xx(:), yy(:));
feat = img(idx);
feat = reshape(feat, [DESC_SIZE, DESC_SIZE]);
% feat = imgaussfilt(feat, SIGMA);
% feat = imresize(feat, [8, 8]);
feat = geo_blur(feat);
feat = feat(1:DESC_SIZE/8:DESC_SIZE, 1:DESC_SIZE/8:DESC_SIZE);
feat = double(feat);
feat = (feat(:) - mean(feat(:)))/std(feat(:));
descs(:, i) = feat;
end
toc
end
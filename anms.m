% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
%
% Adaptive Non-Maximal Suppression
% INPUT:    cimg    corner strength map
%           max_pts number of corners desired
% OUTPUT:   [x, y]  coordinates of corners
%           rmax    suppression radius used to get max_pts corners

function [x, y, rmax] = anms(cimg, max_pts)
% Vectorized l1 norm bfs
tic
H = size(cimg, 1);
W = size(cimg, 2);
r_mat = zeros(H, W);

% cut off lowest 10%
% [hist, bins] = histcounts(cimg);
% min_val = min(cimg(:));
% cutoff = bins(find(cumsum(hist) <0.3*sum(hist),1));
% cimg(cimg(:) < cutoff) = min_val;

for i = 1:H
for j = 1:W
    for r = 1:min(H,W)
        if cimg(i, j) == 0 
            r_mat(i, j) = 1;
            break;
        end
        if  any(cimg(max(1,i-r):min(H,i+r), max(1,j-r)) > cimg(i,j)) > 0 | ...
            any(cimg(max(1,i-r):min(H,i+r), min(W,j+r)) > cimg(i,j)) > 0 | ...
            any(cimg(max(1,i-r), max(1,j-r):min(W,j+r)) > cimg(i,j)) > 0 | ...
            any(cimg(min(H,i+r), max(1,j-r):min(W,j+r)) > cimg(i,j)) > 0
            r_mat(i, j) = r;
            break;
        end
    end
end
end

[x, y] = meshgrid(1:W, 1:H);
mat = [x(:) y(:) r_mat(:)];
[~, idx] = sort(mat(:,3), 'descend');
mat_sorted = mat(idx, :);
x = mat_sorted(1:max_pts,1);
y = mat_sorted(1:max_pts,2);
rmax = mat_sorted(max_pts, 3);
toc
end
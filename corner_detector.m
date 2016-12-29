% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
%
% Detect corner points and return the corner metric matrix
% INPUT:    img     HxW matrix representing the gray scale image
% OUTPUT:   cimg    HxW matrix representing the gray corner metrix matrix
function [cimg] = corner_detector(img)
    if size(img, 3) > 1
        img = rgb2gray(img);
    end
    cimg = cornermetric(img, 'Harris');
end
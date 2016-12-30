% My implementation of harris corner detector
% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
%
% Detect corner points and return the corner metric matrix
% INPUT:    img     HxW matrix representing the gray scale image
% OUTPUT:   cimg    HxW matrix representing the gray corner metrix matrix
function [cimg] = corner_detector(img)
    tic
    if size(img, 3) > 1
        img = rgb2gray(img);
    end
    
    
    a = 0.4;
    G = [1/4 - a/2, 1/4, a, 1/4, 1/4 - a/2];
    dx = G - [G(2:5) 0];
    dy = dx';
    Ix = conv2(img, dx, 'same');
    Iy = conv2(img, dy, 'same');
    
    Ix2 = Ix.*Ix;
    Ixy = Ix.*Iy;
    Iy2 = Iy.*Iy;
    cimg2 = zeros(size(img,1),size(img,2));
    
    for i = 1:size(Ix, 1)
        for j = 1:size(Ix, 2)
            M = [Ix2(i, j), Ixy(i,j);
                 Ixy(i, j), Iy2(i,j)];
            R = det(M) - 0.05*trace(M)^2;
            cimg2(i,j) = R;
        end
    end
    cimg = cimg2;
    toc
end
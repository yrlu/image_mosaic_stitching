% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/09/2016
%
% INPUT:    img:        dxd gray squared feature patch (typically 40x40)
% OUTPUT:   blurred:    geometric blurred feature patch 
function [blurred] = geo_blur(img)
    if size(img, 3) > 1
        img = rgb2gray(double(img)/255);
    end
    d = size(img,1);
    
    % compute multi levels of gaussian
    b_imgs = zeros(size(img,1),size(img,2), round(d/2));
    for i = 1:round(d/2)
        b_imgs(:,:,i) = imgaussfilt(img, (i/4));
    end
    
    blurred = zeros(size(img));
    % vectorized
    [y, x] = meshgrid(1:d, 1:d);
    y = y(:); x = x(:);
    idx = (y == d/2 & x == d/2);
    indices = (x(idx)-1)*d+y(idx);
    blurred(indices) = img(indices);
    indices_not = (x(~idx)-1)*d+y(~idx);
    blurred(indices_not) = b_imgs((round(max(abs(y(~idx) - d/2), abs(x(~idx) - d/2)))-1)*d*d + indices_not);
end
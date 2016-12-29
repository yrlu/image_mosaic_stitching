function [X, Y] = apply_homography(H, x, y)
% [X, Y] = apply_homography(H, x, y)
% Use homogrphay matrix H to compute position (x,y) in the source image to
% the position (X,Y) in the destination image
%
% Input
%   H : 3*3 homography matrix, refer to setup_homography
%   x : the column coords vector, n*1, in the source image
%   y : the column coords vector, n*1, in the source image
% Output
%   X : the column coords vector, n*1, in the destination image
%   Y : the column coords vector, n*1, in the destination image

p1 = [x'; y'; ones(1, length(x))];
q1 = H*p1;
q1 = q1./[q1(3, :); q1(3,:); q1(3, :)];

X = q1(1,:)';
Y = q1(2, :)';
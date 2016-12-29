function H = est_homography(X,Y,x,y)
% H = est_homography(X,Y,x,y)
% Compute the homography matrix from source(x,y) to destination(X,Y)
%
%    X,Y are coordinates of destination points
%    x,y are coordinates of source points
%    X/Y/x/y , each is a vector of n*1, n>= 4
%
%    H is the homography output 3x3
%   (X,Y, 1)^T ~ H (x, y, 1)^T

A = zeros(length(x(:))*2,9);

for i = 1:length(x(:)),
 a = [x(i),y(i),1];
 b = [0 0 0];
 c = [X(i);Y(i)];
 d = -c*a;
 A((i-1)*2+1:(i-1)*2+2,1:9) = [[a b;b a] d];
end

[U S V] = svd(A);
h = V(:,9);
H = reshape(h,3,3)';
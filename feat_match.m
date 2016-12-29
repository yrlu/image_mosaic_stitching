% Author: Yiren Lu
% luyiren@seas.upenn.edu
% Date: 11/06/2016
% 
% INPUTS:
%           descs1 is a 64x(n1) matrix of double values
%           descs2 is a 64x(n2) matrix of double values
% OUTPUTS:
%           match is n1x1 vector of integers where m(i) points to the index of the
%           descriptor in p2 that matches with the descriptor p1(:,i).
%           If no match is found, m(i) = -1

function [match] = feat_match(descs1, descs2)
n1 = size(descs1,2);
n2 = size(descs2,2);
match = zeros(n1, 1);
kdtree = KDTreeSearcher(descs2');
for i = 1:size(descs1,2)
desc = descs1(:, i);
[idx D] = knnsearch(kdtree, desc', 'K', 2);
nn_1 = descs2(:,idx(1));
nn_2 = descs2(:,idx(2));
if sum((desc - nn_1).^2)/sum((desc - nn_2).^2) < 0.6
    match(i) = idx(1);
else
    match(i) = -1;
end

end
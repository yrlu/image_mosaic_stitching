function [ output_args ] = visual_match( img1, img2, x1, y1, x2, y2, inlier)
    x1_inlier = x1(inlier ~= 0);
    y1_inlier = y1(inlier ~= 0);
    x2_inlier = x2(inlier ~= 0);
    y2_inlier = y2(inlier ~= 0); 
    x1_outlier = x1(inlier == 0);
    y1_outlier = y1(inlier == 0);
    x2_outlier = x2(inlier == 0);
    y2_outlier = y2(inlier == 0); 
    
    % visualize image 1 inliers and outliers
    figure;
    imshow(img1);
    hold on;
    scatter(x1_inlier,y1_inlier, 50,'bo');    
    scatter(x1_outlier,y1_outlier, 'rx');    
    hold off;

    % visualize image 2 inliers and outliers
    figure;
    imshow(img2);
    hold on;
    scatter(x2_inlier,y2_inlier, 50,'bo');    
    scatter(x2_outlier,y2_outlier, 'rx');    
    hold off;
end
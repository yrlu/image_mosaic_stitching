function visual_feat( img, cimg, y, x )
    % visualize corner matrix
    figure;
    imagesc(cimg);
    
    % visualize feature detection
    figure;
    imshow(img);
    hold on;
    scatter(x,y, 50, 'r*');
    hold off;
end


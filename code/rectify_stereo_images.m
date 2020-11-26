%% HW3-c
% Given two homography matrices for two images, generate the rectified
% image pair.
function [rectified1, rectified2] = rectify_stereo_images(img1, img2, h1, h2)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here

    % Hint: Note that you should care about alignment of two images.
    % In order to superpose two rectified images, you need to create
    % certain amount of margin.
    tform1 = projective2d(h1);
    img1 = imwarp(img1,tform1);
    tform2 = projective2d(h2);
    img2 = imwarp(img2,tform2);
    
    moving = img1(:,:,1);
    fixed = img2(:,:,1);
    [optimizer, metric] = imregconfig('multimodal');
    img1_red = imregister(moving, fixed, 'translation', optimizer, metric);
    
    moving = img1(:,:,2);
    fixed = img2(:,:,2);
    [optimizer, metric] = imregconfig('multimodal');
    img1_green = imregister(moving, fixed, 'translation', optimizer, metric);
    
    moving = img1(:,:,3);
    fixed = img2(:,:,3);
    [optimizer, metric] = imregconfig('multimodal');
    img1_blue = imregister(moving, fixed, 'translation', optimizer, metric);
    
    new_img1(:,:,1)=img1_red;
    new_img1(:,:,2)=img1_green;
    new_img1(:,:,3)=img1_blue;    
    %% Delete here when you run your code
    rectified1 = new_img1;
    rectified2 = img2;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

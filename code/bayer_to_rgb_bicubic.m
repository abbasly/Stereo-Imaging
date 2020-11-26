%% HW3-a
% Generate the rgb image from the bayer pattern image using linear and
% bicubic interpolation.
function rgb_img = bayer_to_rgb_bicubic(bayer_img)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    bayer_img=im2double(bayer_img);
    
    red_chan=zeros(size(bayer_img));                             %red channel
    red_chan(1:2:end,1:2:end)=bayer_img(1:2:end,1:2:end);
    
    green_chan=zeros(size(bayer_img));                           %green channel
    green_chan(1:2:end,2:2:end)=bayer_img(1:2:end,2:2:end);
    green_chan(2:2:end,1:2:end)=bayer_img(2:2:end,1:2:end);
    
    blue_chan=zeros(size(bayer_img));                            %blue channel
    blue_chan(2:2:end,2:2:end)=bayer_img(2:2:end,2:2:end);
    
    % fixing empty greens
    green_chan= green_chan + imfilter(green_chan, [0 1 0; 1 0 1; 0 1 0]/4);
    
% fixing empty blues
% empty blues in red locations
    blue1 = imfilter(blue_chan,[1 0 1; 0 0 0; 1 0 1]/4);
% empty blues in green locations
% by averaging the four neighouring blue pixels
    blue2 = imfilter(blue_chan+blue1,[0 1 0; 1 0 1; 0 1 0]/4);
    blue_chan = blue_chan + blue1 + blue2;
    
% fixing empty reds
% missing red pixels at the blue location
    red1 = imfilter(red_chan,[1 0 1; 0 0 0; 1 0 1]/4);
% missing red pixels at the green locations   
    red2 = imfilter(red_chan+red1,[0 1 0; 1 0 1; 0 1 0]/4);
    red_chan = red_chan + red1 + red2;
    %% Delete here when you run your code
    rgb_img(:,:,1)=red_chan;
    rgb_img(:,:,2)=green_chan;
    rgb_img(:,:,3)=blue_chan;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

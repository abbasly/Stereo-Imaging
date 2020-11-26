%% HW3-d
% Generate the disparity map from two rectified images. Use NCC for the
% mathing cost function.
function d = calculate_disparity_map(img_left, img_right, window_size, max_disparity)

half_window=fix(window_size/2);

d=zeros(size(img_right));
cost_vol = zeros(size(img_left,1),size(img_left,2),max_disparity+1);

for i=half_window+1:size(img_left,1)-half_window
    for j=half_window+1:size(img_left,2)-half_window
        
        blockR=img_right(i-half_window:i+half_window,j-half_window:j+half_window);
        blockR=blockR-mean(blockR,"all");

        for k=0:min(max_disparity,size(img_left,2)-half_window-j)
            blockL=img_left(i-half_window:i+half_window,j-half_window+k:j+half_window+k);
            blockL=blockL-mean(blockL,"all");
            
            %cost_vol(i,j,k+1 = sum(abs(blockL(:) -  blockR(:)));
            %cost_vol(i,j,k+1) = sum((blockL(:)-blockR(:)).^2);
            cost_vol(i,j,k+1)=(blockL(:)'*blockR(:))/(norm(blockL(:))*norm(blockR(:)));

        end
        

    end
end
%filter=1/9*[1,1,1;1,1,1;1,1,1];
%filter=fspecial('disk',10);
filter =fspecial('average',5);
cost_vol=imfilter(cost_vol,filter);
[~, d] = min(cost_vol,[],3);
d=d-1;

end

function upsample
original = imread('graylizard_downsample.bmp');
%original = rgb2gray(imread('city.jpg'));
upsampled = mat2gray(bicubic_int(original,2,1));

figure;
imshow(original);
title('Original');
figure;
imshow(upsampled);
title('Upsampled by 2');
end
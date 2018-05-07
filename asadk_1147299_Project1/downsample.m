function downsample
original = imread('graylizard.bmp');
%original = rgb2gray(imread('city.jpg'));
downsampled = bicubic_int(original,1,2);
%downsampled = original(1:2:end, 1:2:end);
final = bicubic_int(downsampled,2,1);

D = abs(double(original)-double(final)).^2;
MSE = sqrt(sum(D(:))/numel(original));
display(MSE);

downsampled = mat2gray(downsampled);
final = mat2gray(final);

figure;
imshow(original);
title('Original');
figure;
imshow(downsampled);
title('Downsampled by 2');
figure;
imshow(final);
title('Reupsampled by 2');
end
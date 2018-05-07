function testscript
original = rgb2gray(imread('city.jpg'));
upsampled = mat2gray(bicubic_int(original,2,1));
upsampled = mat2gray(bicubic_int(upsampled,2,1));
end
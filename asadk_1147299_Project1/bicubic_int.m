function im_zoom = bicubic_int(original, zoom, s);
w = original;                       
%w=rgb2gray(original);              %convert to grayscale
[r,c,d] = size(w);                  %number of rows and columns and depth
r_new = r*zoom/s;                   %create new row and column variables
c_new = c*zoom/s;                   %depending on up or down sample
r_zoom = r_new/(r-1);               %
c_zoom = c_new/(c-1);
img = zeros(r_new,c_new,d);

[x,y,z] = derive(w,r,c,s);

img = make(r_zoom, c_zoom, img, r_new, c_new, w, x, y, z);

%im_zoom = mat2gray(img);
im_zoom = img;
end



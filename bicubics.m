function bicubics;
image=rgb2gray(imread('grumpycat.jpeg'));
zoom=1;
[r c d] = size(image);                          %row, column, depth
rn = floor(zoom*r);                             %row number(rounded down)
cn = floor(zoom*c);                             %col number(rounded down)
s = zoom;
im_zoom = cast(zeros(rn,cn,d),'uint8');         %convert to uint8
im_pad = zeros(r+4,c+4,d);                      %
im_pad(2:r+1,2:c+1,:) = image;                  %pad 3 col/rows of 0s
im_pad = cast(im_pad,'double');                 %change type to double
for m = 1:rn-3                                  %read each 4 rows
    for n = 1:cn-3                              %read each 4 columns
		a00 = image(m+1,n+1);
		a01 = -.5*image(m+1,n) + .5*image(m+1,n+2);
		a02 = image(m+1,n) - 2.5*image(m+1,n+1) + 2*image(m+1,n+2) - .5*image(m+1,n+3);
		a03 = -.5*image(m+1,n) + 1.5*image(m+1,n+1) - 1.5*image(m+1,n+2) + .5*image(m+1,n+3);
		a10 = -.5*image(m,n+1) + .5*image(m+2,n+1);
		a11 = .25*image(m,n) - .25*image(m,n+2)- .25*image(m+2,n) + .25*image(m+2,n+2);
		a12 = -.5*image(m,n) + 1.25*image(m,n+1) - image(m,n+3) + .25*image(m,n+3) + .5*image(m+2,n) - 1.25*image(m+2,n+1) + image(m+2,n+2) - .25*image(m+2,n+3);
		a13 = .25*image(m,n) - .75*image(m,n+1) + .75*image(m,n+3) - .25*image(m,n+3) - .25*image(m+2,n) + .75*image(m+2,n+1) - .75*image(m+2,n+2) + .25*image(m+2,n+3);
		a20 = image(m,n+1) - 2.5*image(m+1,n+1) + 2*image(m+2,n+1) - .5*image(m+3,n+1);
		a21 = -.5*image(m,n) + .5*image(m,n+2) + 1.25*image(m+1,n) - 1.25*image(m+1,n+2) - image(m+2,n) + image(m+2,n+2) + .25*image(m+3,n) - .25*image(m+3,n+2);
		a22 = image(m,n) - 2.5*image(m,n+1) + 2*image(m,n+2) - .5*image(m,n+3) - 2.5*image(m+1,n) + 6.25*image(m+1,n+1) - 5*image(m+1,n+2) + 1.25*image(m+1,n+3) + 2*image(m+2,n) - 5*image(m+2,n+1) + 4*image(m+2,n+2) - image(m+2,n+3) - .5*image(m+3,n) + 1.25*image(m+3,n+1) - image(m+3,n+2) + .25*image(m+3,n+3);
		a23 = -.5*image(m,n) + 1.5*image(m,n+1) - 1.5*image(m,n+2) + .5*image(m,n+3) + 1.25*image(m+1,n) - 3.75*image(m+1,n+1) + 3.75*image(m+1,n+2) - 1.25*image(m+1,n+3) - image(m+2,n) + 3*image(m+2,n+1) - 3*image(m+2,n+2) + image(m+2,n+3) + .25*image(m+3,n) - .75*image(m+3,n+1) + .75*image(m+3,n+2) - .25*image(m+3,n+3);
		a30 = -.5*image(m,n) + 1.5*image(m+1,n+1) - 1.5*image(m+2,n+1) + .5*image(m+3,n+1);
		a31 = .25*image(m,n) - .25*image(m,n+2) - .75*image(m+1,n) + .75*image(m+1,n+2) + .75*image(m+2,n) - .75*image(m+2,n+2) - .25*image(m+3,n) + .25*image(m+3,n+2);
		a32 = -.5*image(m,n) + 1.25*image(m,n+1) - image(m,n+2) + .25*image(m,n+2) + 1.5*image(m+1,n) - 3.75*image(m+1,n+1) + 3*image(m+1,n+2) - .75*image(m+1,n+3) - 1.5*image(m+2,n) + 3.75*image(m+2,n+1) - 3*image(m+2,n+2) + .75*image(m+2,n+3) + .5*image(m+3,n) - 1.25*image(m+3,n+1) + image(m+3,n+2) - .25*image(m+3,n+3);
		a33 = .25*image(m,n) - .75*image(m,n+1) + .75*image(m,n+2) - .25*image(m,n+3) - .75*image(m+1,n) + 2.25*image(m+1,n+1) - 2.25*image(m+1,n+2) + .75*image(m+1,n+3) + .75*image(m+2,n) - 2.25*image(m+2,n+1) + 2.25*image(m+2,n+2) - .75*image(m+2,n+3) - .25*image(m+3,n) + .75*image(m+3,n+1) - .75*image(m+3,n+2) + .25*image(m+3,n+3);
        
        x=0;y=0;
        im_zoom(m,n) = a00 + a10*x + a01*y + a20*(x^2) + a11*x*y + a02*(y^2) + a21*(x^2)*y + a12*x*(y^2) + a22*(x^2)*(y^2) + a30*(x^3) + a03*(y^3) + a31*(x^3)*y + a13*x*(y^3) + a32*(x^3)*(y^2)+ a23*(x^2)*(y^3) + a33*(x^3)*(y^3);
        x=0;y=0.5;
        im_zoom(m,n+1) = a00 + a10*x + a01*y + a20*(x^2) + a11*x*y + a02*(y^2) + a21*(x^2)*y + a12*x*(y^2) + a22*(x^2)*(y^2) + a30*(x^3) + a03*(y^3) + a31*(x^3)*y + a13*x*(y^3) + a32*(x^3)*(y^2)+ a23*(x^2)*(y^3) + a33*(x^3)*(y^3);
        x=0.5;y=0;
        im_zoom(m+1,n) = a00 + a10*x + a01*y + a20*(x^2) + a11*x*y + a02*(y^2) + a21*(x^2)*y + a12*x*(y^2) + a22*(x^2)*(y^2) + a30*(x^3) + a03*(y^3) + a31*(x^3)*y + a13*x*(y^3) + a32*(x^3)*(y^2)+ a23*(x^2)*(y^3) + a33*(x^3)*(y^3);
        x=0.5;y=0.5;
        im_zoom(m+1,n+1) = a00 + a10*x + a01*y + a20*(x^2) + a11*x*y + a02*(y^2) + a21*(x^2)*y + a12*x*(y^2) + a22*(x^2)*(y^2) + a30*(x^3) + a03*(y^3) + a31*(x^3)*y + a13*x*(y^3) + a32*(x^3)*(y^2)+ a23*(x^2)*(y^3) + a33*(x^3)*(y^3);
    end
end
im_zoom = cast(im_zoom,'uint8');
imshow(mat2gray(im_zoom));
function im_zoom = bicubics(image,zoom);
[r c d] = size(image);                          %row, column, depth
rn = floor(zoom*r);                             %row number(rounded down)
cn = floor(zoom*c);                             %col number(rounded down)
s = zoom;
im_zoom = cast(zeros(rn,cn,d),'uint8');         %convert to uint8
im_pad = zeros(r+4,c+4,d);                      %
im_pad(2:r+1,2:c+1,:) = image;                  %pad 3 col/rows of 0s
im_pad = cast(im_pad,'double');                 %change type to double
for m = 1:4:rn                                  %read each 4 rows
    for n = 1:4:cn                              %read each 4 columns
		a00 = image(m+1,n+1);
		a01 = -.5*image(m+1,n) + .5*image(m+1,n+2);
		a02 = image(m+1,n) - 2.5*image(m+1,n+1) + 2*image(m+1,n+2) - .5*image(m+1,n+3);
		a03 = -.5*image(m+1,n) + 1.5*image(m+1,n+1) - 1.5*image(m+1,n+2) + .5*image(m+1,n+3);
		a10 = -.5*image(m,n+1) + .5*image(m+2,n+1);
		a11 = .25*image(m,n) - .25*image(m,n+2)- .25*image(m+2,n) + .25*image(m+2,n+2);
		a12 = -.5*image(m,n) + 1.25*image(m,n+1) - image(m+0,n+3) + .25*image(m,n+3) + .5*image(m+2,n) - 1.25*image(m+2,n+1) + image(m+2,n+2) - .25*image(m+2,n+3);
		a13 = .25*image(m,n) - .75*image(m,n+1) + .75*image(m,n+3) - .25*image(m,n+3) - .25*image(m+2,n) + .75*image(m+2,n+1)- .75*image(m+2,n+2) + .25*image(m+2,n+3);
		a20 = image(m,n+1) - 2.5*image(m+1,n+1) + 2*image(m+2,n+1) - .5*image(m+3,n+1);
		a21 = -.5*image(m,n) + .5*image(m,n+2) + 1.25*image(m+1,n) - 1.25*image(m+1,n+2) - image(m+2,n) + image(m+2,n+2) + .25*image(m+3,n+0) - .25*image(m+3,n+2);
		a22 = image(m,n) - 2.5*image(m,n+1) + 2*image(m,n+2) - .5*image(m,n+3) - 2.5*image(m+1,n) + 6.25*image(m+1,n+1) - 5*image(m+1,n+2) + 1.25*image(m+1,n+3) + 2*image(m+2,n) - 5*image(m+2,n+1) + 4*image(m+2,n+2) - image(m+2,n+3) - .5*image(m+3,n+0) + 1.25*image(m+3,n+1) - image(m+3,n+2) + .25*image(m+3,n+3);
		a23 = -.5*image(m,n) + 1.5*image(m,n+1) - 1.5*image(m,n+2) + .5*image(m,n+3) + 1.25*image(m+1,n) - 3.75*image(m+1,n+1) + 3.75*image(m+1,n+2) - 1.25*image(m+1,n+3) - image(m+2,n) + 3*image(m+2,n+1) - 3*image(m+2,n+2) + image(m+2,n+3) + .25*image(m+3,n+0) - .75*image(m+3,n+1) + .75*image(m+3,n+2) - .25*image(m+3,n+3);
		a30 = -.5*image(m,n) + 1.5*image(m+1,n+1) - 1.5*image(m+2,n+1) + .5*image(m+3,n+1);
		a31 = .25*image(m,n) - .25*image(m,n+2) - .75*image(m+1,n) + .75*image(m+1,n+2) + .75*image(m+2,n) - .75*image(m+2,n+2) - .25*image(m+3,n) + .25*image(m+3,n+2);
		a32 = -.5*image(m,n) + 1.25*image(m,n+1) - image(m,n+2) + .25*image(m,n+2) + 1.5*image(m+1,n) - 3.75*image(m+1,n+1) + 3*image(m+1,n+2) - .75*image(m+1,n+3) - 1.5*image(m+2,n) + 3.75*image(m+2,n+1) - 3*image(m+2,n+2) + .75*image(m+2,n+3) + .5*image(m+3,n+0) - 1.25*image(m+3,n+1) + image(m+3,n+2) - .25*image(m+3,n+3);
		a33 = .25*image(m,n) - .75*image(m,n+1) + .75*image(m,n+2) - .25*image(m,n+3) - .75*image(m+1,n) + 2.25*image(m+1,n+1) - 2.25*image(m+1,n+2) + .75*image(m+1,n+3) + .75*image(m+2,n) - 2.25*image(m+2,n+1) + 2.25*image(m+2,n+2) - .75*image(m+2,n+3) - .25*image(m+3,n+0) + .75*image(m+3,n+1) - .75*image(m+3,n+2) + .25*image(m+3,n+3);
    end
end
im_zoom = cast(im_zoom,'uint8');
function im_zoom = bicubic(image,zoom);
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
        w0 = im_pad(m+3,n);                      %lower left point
        w1 = im_pad(m+3,n+3);                    %lower right point
        w2 = im_pad(m,n);                        %upper left point
        w3 = im_pad(m,n+3);                      %upper right point
        
        x0 = (im_pad(m+1,n)-im_pad(m-1,n))/2;     %lower left point
        x1 = im_pad(m+3,n+3);                    %lower right point
        x2 = im_pad(m,n);                        %upper left point
        x3 = im_pad(m,n+3);                      %upper right point
        
        y0 = (im_pad(m,n+1)-im_pad(m,n-1))/2;     %lower left point
        y1 = im_pad(m+3,n+3);                    %lower right point
        y2 = im_pad(m,n);                        %upper left point
        y3 = im_pad(m,n+3);                      %upper right point
        
        z0 = (im_pad(m+1,n+1)-im_pad(m-1,n)-im_pad(m,n-1)-im_pad(m,n))/4;     %lower left point
        z1 = im_pad(m+3,n+3);                    %lower right point
        z2 = im_pad(m,n);                        %upper left point
        z3 = im_pad(m,n+3);                      %upper right point
        
        a00 = w0;
        a01 = y0;
        a02 = -3*w0 + 3*w2 -2*y0 - y2;
        a03 = 2*w0 - 2*w2 + y0 + y2;
        a10 = x0;
        a11 = z0;
        a12 = -3*x0 + 3*x2 - 2*z0 - z2;
        a13 = 2*x0 - 2*x2 + z0 + z2;
        a20 = -3*w0 + 3*w1 - 2*x0 - x1;
        a21 = -3*y0 + 3*y1 - 2*z0 - z1;
        a22 = 9*w0 - 9*w1 - 9*w2 + 9*w3 + 6*x0 + 3*x1 -6*x2 -3*x3 + 6*y0 - 6*y1 + 3*y2 - 3*y3 + 4*z0 + 2*z1 + 2*z2 + z3;
        a23 = -6*w0 + 6*w1 + 6*w2 - 6*w3 -4*x0 -2*x1 + 4*x2 + 2*x3 -3*y0 + 3*y1 - 3*y2 + 3*y3 + -2*z0 - z1 - 2*z2 - z3;
        a30 = 2*w0 - 2*w1 + x0 + x1;
        a31 = 2*y0 - 2*y1 + z0 + z1;
        a32 = -6*w0 + 6*w1 + 6*w2 -6*w3 -3*x0 - 3*x1 + 3*x2 + 3*x3 -4*y0 + 4*y1 - 2*y2 + 2*y3 + -2*z0 - 2*z1 - z2 - z3;
        a33 = 4*w0 - 4*w1 - 4*w2 + 4*w3 + 2*x0 + 2*x1 + -2*x2 - 2*x3 + 2*y0 - 2*y1 + 2*y2 - 2*y3 + z0 + z1 + z2 + z3;
    end
end
im_zoom = cast(im_zoom,'uint8');
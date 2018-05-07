function [x,y,z] = derive(w,r,c,s)
x = zeros(r,c);
y = zeros(r,c);
z = zeros(r,c);
for i=1:s:r
    for j=1:s:c     
        if((i==1)||(i==r))                      %horizontal edge case
            x(i,j) = 0;                         %pad zeros
        elseif ((j==1)||(j==c))                 %vertical edge case
            y(i,j) = w(i,j);                    %keep original value
        elseif ((i~=1)&&(i~=r))                 
            x(i,j) = (w(i+1,j)-w(i-1,j))./2;    %x derivative using slope
        elseif ((j~=1)&&(j~=c))
            y(i,j) = (w(i,j+1)-w(i,j-1))./2;    %y derivative using slope
        elseif ((i~=1)&&(i~=r)&&(j~=1)&&(j~=c)) %xy derivative using slope
            z(i,j) = (w(i+1,j+1)-w(i-1,j)-w(i,j-1)+w(i,j))./4;
        end
    end
end
end
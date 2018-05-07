function kevin;
clear

%car='alfa.jpg';

%bird= 'bird.png';

%hires= 'hires.jpg';

hires2= 'biel.jpg';

%hires2= 'grey_scale.gif';

imagein= imread(hires2); %comment out if image is already grayscale

imagein=rgb2gray(imagein);

imsize=size(imagein);

y=imsize(1);

x=imsize(2);

w=255;

imageout= zeros(y,x);

imageout(1:y, 1:x)=0;

figure(1)

I=mat2gray(imagein, [0, 255]);

imshow(I);

title('Original');

i=1;

j=1;

while j<=y

 while i<=x

imageout(j,i)=imagein(j,i);

i=i+2;

 end

% if(flag==0)

% flag=1;

% else

% flag=0;

% end

%

% if (flag==1)

% i=2;

% else

% i=1;

% end

i=1;

j=j+2;

end

figure(2)

I=mat2gray(imageout, [0, 255]);

imshow(I);

title('Down Sampled');

j=4;

i=4;

flag=0;

B=[-1 1 -1 1; 0 0 0 1; 1 1 1 1; 8 4 2 1;];

Binv= [-1/6 1/2 -1/2 1/6;

1/2 -1 1/2 0;

-1/3 -1/2 1 -1/6;

0 1 0 0];

BinvT= transpose(Binv);

while j<=(y-3)

 while i<=(x-3)

 if(0)

imageout(j,i)=0;

% elseif(i==x)

% i1= (imageout(j-1,i)+imageout(j+1,i))/2;

% i2= imageout(j,i-1);

% imageout(j,i)=(i1+i2)/2;

%

% elseif(j==y)

% i1= imageout(j-1,i);

% i2= (imageout(j,i-1)+imageout(j,i+1))/2;

% imageout(j,i)=(i1+i2)/2;

%

% elseif(i==1)

% i1= (imageout(j-1,i)+imageout(j+1,i))/2;

% i2= imageout(j,i+1);

% imageout(j,i)=(i1+i2)/2;

%

% elseif(j==1)

% i1= imageout(j,i+1);

% i2= (imageout(j,i-1)+imageout(j,i+1))/2;

% imageout(j,i)=(i1+i2)/2;

 else %fill matrix with f elements

f22=imageout(j+1,i-1); %f(0,0)

f23=imageout(j-1,i-1); %f(0,1)

f32=imageout(j+1,i+1); %f(1,0)

f33=imageout(j-1,i+1); %f(1,1)

f12=imageout(j+1,i-3); %f(-1,0)

f11=imageout(j+3,i-3); %f(-1,-1)

f13=imageout(j-1,i-3); %f(-1,1)

f14=imageout(j-3,i-3); %f(-1,2)

f44=imageout((j-3),(i+3)); %f(2,2)

f43=imageout(j-1,i+3); %f(2,1)

f42=imageout(j+1,i+3); %f(2,0)

f41=imageout(j+3,i+3); %f(2,-1)

f21=imageout(j+3,i-1); %f(0,-1)

f24=imageout(j-3,i-1); %f(0,2)

f31=imageout(j+3,i+1); %f(1,-1)

f34=imageout(j-3,i+1); %f(1,2)

F=[f11 f12 f13 f14;

f21 f22 f23 f24;

f31 f32 f33 f34;

f41 f42 f43 f44;];

xV=[0 0 0 1];

yV=[0;

0;

0;

1;];

A=Binv*F*BinvT;

X=[1/8 1/4 1/2 1];

Xm=[-1/16 9/16 9/16 -1/16];

imageout(j,i)= X*A*transpose(X);

imageout(j+1,i)= X*A*yV;

imageout(j,i-1)= xV*A*transpose(X);

 end

i=i+2;

 end

i=4;

j=j+2;

end

%imagesc(imageout,[0,255]); colormap(gray);

figure(3);

I=mat2gray(imageout, [0, 255]);

imshow(I);

title('Bicubic Interpolation');
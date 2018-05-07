function [ output_args ] = labtq4( input_args )

	M_inv = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0; 0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0;-3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0; 2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0; 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0; 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0; 0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0; 0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0; -3,0,3,0,0,0,0,0,-2,0,-1,0,0,0,0,0; 0,0,0,0,-3,0,3,0,0,0,0,0,-2,0,-1,0; 9,-9,-9,9,6,3,-6,-3,6,-6,3,-3,4,2,2,1; -6,6,6,-6,-3,-3,3,3,-4,4,-2,2,-2,-2,-1,-1; 2,0,-2,0,0,0,0,0,1,0,1,0,0,0,0,0; 0,0,0,0,2,0,-2,0,0,0,0,0,1,0,1,0; -6,6,6,-6,-4,-2,4,2,-3,3,-3,3,-2,-1,-2,-1; 4,-4,-4,4,2,2,-2,-2,2,-2,2,-2,1,1,1,1 ];

	B = [-1 1 -1 1; 0 0 0 1; 1 1 1 1; 8 4 2 1];
	B_inv = [-1/6 0.5 -0/5 1/6; 0.5 -1 0.5 0; -1/3 -1/2 1 -1/6; 0 1 0 0];
	A = imread('cat.bmp');
	A = (rgb2gray(A));


	n = 2;

	%A = imresize(A,0.5);
	%A = A(1:n:end,1:n:end);

	[j , k] = size(A);
	%[j k c] = size(A);
	x_new = j * n ;
	y_new = k * n ;

	x_scale = x_new./(j-1);
	y_scale = y_new./(k-1);

	temp_image = zeros(x_new,y_new,1);

	Ix = (zeros(j,k));
	Iy = (zeros(j,k));
	Ixy = (zeros(j,k));
	for count1 = 1:j
		for count2 = 1:k
			if ((count2 ==1)||(count2==k))
				Ix(count1,count2) = 0;
			else
				Ix(count1,count2) = (0.5).*(A(count1,count2+1)-A(count1,count2-1));
			end
			if ((count1 ==1)||(count1==j))
				Iy(count1,count2) = A(count1,count2);
			else
				Iy(count1,count2) = (0.5).*(A(count1+1,count2)-A(count1-1,count2));
			end
			if (count1 ==1)||(count1==j)||(count2 ==1)||(count2==k)
				Ix(count1,count2) = 0;
			else
				Ixy(count1,count2) = (0.25).*(A(count1+1,count2+1)-A(count1-1,count2)-A(count1,count2-1)+A(count1,count2));
			end
		end
	end

for count1 = 0:x_new-1
	for count2 = 0:y_new-1
% 		beta = [A(count1,count2) A(count1+1,count2) A(count1,count2+1) A(count1+1,count2+1) Ix(count1,count2) Ix(count1+1,count2) Ix(count1,count2+1) Ix(count1+1,count2+1) Iy(count1,count2) Iy(count1+1,count2) Iy(count1,count2+1) Iy(count1+1,count2+1) Ixy(count1,count2) Ixy(count1+1,count2) Ixy(count1,count2+1) Ixy(count1+1,count2+1)]

% 		alpha = M_inv * beta.'
	% for count1 = 1:j-1
	% 	for count2 = 1:k-1
	% 		temp_image(count1*2,count2*2,1) = A(count1,count2,1);

		% a00 = A(count1/2,count2/2);
		% a01 = Iy(count1/2,count2/2);
		% a02 = -3*A(count1/2,count2/2) + 3*A(count1/2,(count2/2)+1) -2*Iy(count1/2,count2/2) - Iy
 			W = -(((count1./x_scale)-floor(count1./x_scale))-1);
 			H = -(((count2./y_scale)-floor(count2./y_scale))-1);
			I11_index = [1+floor(count1/x_scale),1+floor(count2/y_scale)];

 			I21_index = [1+floor(count1/x_scale),1+ceil(count2/y_scale)];

 			I12_index = [1+ceil(count1/x_scale),1+floor(count2/y_scale)];

 			I22_index = [1+ceil(count1/x_scale),1+ceil(count2/y_scale)];

 			I11 = A(I11_index(1),I11_index(2));

 			I21 = A(I21_index(1),I21_index(2));

 			I12 = A(I12_index(1),I12_index(2));

 			I22 = A(I22_index(1),I22_index(2));

 			Ix11 = Ix(I11_index(1),I11_index(2));

 			Ix21 = Ix(I21_index(1),I21_index(2));

 			Ix12 = Ix(I12_index(1),I12_index(2));

 			Ix22 = Ix(I22_index(1),I22_index(2));

 			Iy11 = Iy(I11_index(1),I11_index(2));

 			Iy21 = Iy(I21_index(1),I21_index(2));

 			Iy12 = Iy(I12_index(1),I12_index(2));

 			Iy22 = Iy(I22_index(1),I22_index(2));

 			Ixy11 = Ixy(I11_index(1),I11_index(2));

 			Ixy21 = Ixy(I21_index(1),I21_index(2));

 			Ixy12 = Ixy(I12_index(1),I12_index(2));

 			Ixy22 = Ixy(I22_index(1),I22_index(2));

 			beta = [I11; I21; I12; I22; Ix11; Ix21; Ix12; Ix22; Iy11; Iy21; Iy12; Iy22; Ixy11; Ixy21; Ixy12; Ixy22];
 			%beta = [A(count1,count2) A(count1+1,count2) A(count1,count2+1) A(count1+1,count2+1) Ix(count1,count2) Ix(count1+1,count2) Ix(count1,count2+1) Ix(count1+1,count2+1) Iy(count1,count2) Iy(count1+1,count2) Iy(count1,count2+1) Iy(count1+1,count2+1) Ixy(count1,count2) Ixy(count1+1,count2) Ixy(count1,count2+1) Ixy(count1+1,count2+1)];
			alpha = (M_inv) * double(beta);
 			%ib=beta.';
			% alpha =double(M_inv)*double(ib);
			temp_p=0;

			
			%temp_p = alpha(1)*((count1-1)^0)*((count2-1)^0) + alpha(2)*((count1-1)^1)*((count2-1)^0) + alpha(3)*((count1-1)^2)*((count2-1)^0) + alpha(4)*((count1-1)^3)*((count2-1)^0) + alpha(5)*((count1-1)^0)*((count2-1)^1) + alpha(6)*((count1-1)^1)*((count2-1)^1) + alpha(7)*((count1-1)^2)*((count2-1)^1) + alpha(8)*((count1-1)^3)*((count2-1)^1) + alpha(9)*((count1-1)^0)*((count2-1)^2) + alpha(10)*((count1-1)^1)*((count2-1)^2) + alpha(11)*((count1-1)^2)*((count2-1)^2) + alpha(12)*((count1-1)^3)*((count2-1)^2) + alpha(13)*((count1-1)^0)*((count2-1)^3) + alpha(14)*((count1-1)^1)*((count2-1)^3) + alpha(15)*((count1-1)^2)*((count2-1)^3) + alpha(16)*((count1-1)^3)*((count2-1)^3);

			for count3 = 1:16
			 	w_temp = floor((count3-1)/4);
			 	h_temp = mod(count3-1,4);
	 	 		temp_p = temp_p + alpha(count3).*((1-W)^(w_temp)).*((1-H)^(h_temp));
			end
			temp_image(count1+1,count2+1,1)=temp_p;
        end
    end
    disp('done')
	output_image = mat2gray(temp_image);
	[x,y,z]=size(output_image);
	imshow(output_image);

	% function H = Interpolate(x,y)
	% 	w0 = A(x,y);
	% 	w1 = A(x+1,y);
	% 	w2 = A(x,y+1);
	% 	w3 = A(x+1,y+1);

	% 	x0 = Ix(x,y);
	% 	x1 = Ix(x+1,y);
	% 	x2 = Ix(x,y+1);
	% 	x3 = Ix(x+1,y+1);

	% 	y0 = Iy(x,y);
	% 	y1 = Iy(x+1,y);
	% 	y2 = Iy(x,y+1);
	% 	y3 = Iy(x+1,y+1);

	% 	z0 = Iy(x,y);
	% end
end

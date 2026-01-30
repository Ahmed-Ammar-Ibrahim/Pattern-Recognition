Ir = imread('coin.png');
I = rgb2gray(Ir);
%% salt&pepper noise
I1=imnoise(I,'salt & pepper');
subplot(3,3,1);
imshow(I1)
title('salt & pepper');
%% speckle noise
I2=imnoise(I,'speckle');
subplot(3,3,2);
imshow(I2)
title('speckle');
%% perodic noise
s=size(I);
[x,y]=meshgrid(1:s(1),1:s(2));
p=sin(x/3+y/5)+1;
p1=p';
I3=(im2double(I)+p1/2)/2; %% convert image to double and added it to noise
subplot(3,3,3);
imshow(I3)
title('Perodic');
%% filtering
filt_s = medfilt2(I2);
filt2_p = medfilt2(I3);
filt3_b = medfilt2(I1);
subplot(3,3,4);
imshow(filt3_b);
title('median1');
subplot(3,3,5)
imshow(filt_s)
title('median1');
subplot(3,3,6)
imshow(filt2_p)
title('median1');
%% filtering 2 using Ring filter
[r,c] = size (I); % taking the size of image
[x, y] = meshgrid(1:c, 1:r); 
p1 = 1 + sin ( x + y );
I2 = im2double(I) + p1 ;
tgpf = fftshift ( fft2 (I2) );
figure()
subplot(2,3,1); imshow(mat2gray (I*1.2)) ;title ('original gray') ;
subplot(2,3,2); imshow((I2/2));title('noisy image in Spatial domain');
subplot(2,3,3);imshow (mat2gray( log ( abs(tgpf) ) ) ) ; title('noisy image in Freq. domain ') ;
z = sqrt ( ( x - c/2 ).^2 + ( y - r/2 ).^2 );
F= ( z < 135 | z > 145 );
resf = tgpf .* F ;
resi = ifft2 ( resf );
subplot(2,3,4);imshow (mat2gray( log (1+ abs(resf) ) ) ); title ('noisyimage X Ring filter ') ;
subplot (2,3,5);imshow (mat2gray ( log (1+ abs(resi) ) ) ) ; title('F= ( z < 135 | z > 145 );') ;
F2 = ( z < 20 | z > 190 );
resf2 = tgpf .* F2 ;
resi2 = ifft2 ( resf2 );
subplot(2,3,6);imshow(mat2gray ( log (1+ abs(resi2) ) ) ) ; title('F2= ( z < 20 | z > 190 ); ') ;
%% MSE 
error1 = immse(filt_s,I);
filt2_p1 = uint8(filt2_p);
error2 = immse(filt2_p1,I);
error3 = immse(filt3_b,I);
j = mat2gray(log(1+ abs(resi2)));
j1 = uint8(j);
error4 = immse(j1,I);

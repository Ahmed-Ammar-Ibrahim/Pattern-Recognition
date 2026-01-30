% Task 2. Statstical Features of an Image

%Creating 5 images (5 Matrecis)
I_rgb= imread('PR1.jpeg'); 
I = rgb2gray(I_rgb);
I_noise = imnoise(I,'gaussian');  %Gaussian noise
I_Histo_eq = histeq(I);           %Histogram Equalization
I_adaptive = adapthisteq(I);      %Adaptive Histogram
I_filt = medfilt2(I_noise);      %median filter

%Showing the images
figure ('Name','Original Image')
imshow(I);
figure ('Name','With added Nosie')
imshow(I_noise);
figure ('Name','Histogram Equalization')
imshow(I_Histo_eq);
figure ('Name','Adaptive Histogram Equalization')
imshow(I_adaptive);
figure ('Name','Median Filtered Image')
imshow(I_filt);


%Converting to data type (double)
I = double(I);
I_noise = double(I_noise );
I_Histo_eq = double(I_Histo_eq);
I_adaptive = double(I_adaptive);
I_filt = double(I_filt);


[rows1,columns1,Channels1] = size(I); 
[rows2,columns2,Channels2] = size(I_noise); 
[rows3,columns3,Channels3] = size(I_Histo_eq); 
[rows4,columns4,Channels4] = size(I_adaptive); 
[rows5,columns5,Channels5] = size(I_filt); 

% Calaculation of the Mean of an image

mean1 = sum(I(:))/(rows1*columns1)
mean2 = sum(I_noise(:))/(rows2*columns2)
mean3 = sum(I_Histo_eq(:))/(rows3*columns3)
mean4 = sum(I_adaptive(:))/(rows4*columns4)
mean5 = sum(I_filt(:))/(rows5*columns5)



%Calculation of the Variance
%for orginial
x=(I-mean1).^2;
totsum=sum(x(:));
y=(rows1*columns1)-1;
var1 = totsum/y
%for noise image
x=(I_noise-mean2).^2;
totsum=sum(x(:));
y=(rows2*columns2)-1;
var2 = totsum/y
%for histogram eq 
x=(I_Histo_eq-mean3).^2;
totsum=sum(x(:));
y=(rows3*columns3)-1;
var3 = totsum/y
%for adaptive
x=(I_adaptive-mean4).^2;
totsum=sum(x(:));
y=(rows4*columns4)-1;
var4 = totsum/y
%for Filtered image
x=(I_filt-mean5).^2;
totsum=sum(x(:));
y=(rows5*columns5)-1;
var5 = totsum/y

%Calculation of the Standard Deviation

Std_Dev1=sqrt(var1)
Std_Dev2=sqrt(var2)
Std_Dev3=sqrt(var3)
Std_Dev4=sqrt(var4)
Std_Dev5=sqrt(var5)


%For original Image

%Calculation of the Median

 C=reshape(I,[],1);
 min1=min(C);
 max1=max(C);

 E=sort(I(:));
 num=round((rows1*columns1)/2);

 if( (mod(rows1,2)==0) || (mod(columns1,2)==0) )
     median1=(E(num)+E(num+1))/2
    
 else
     median1 = E(num)
 end

 %Calculation of the Mode
 
   D=hist(C,min1:max1);
   D1=find(D==max(D));
   mode1 =D1(1)+min1-1
   
   
   
   
   %For Noisey image
   
   %Calculation of the Median

 C=reshape(I_noise,[],1);
 min1=min(C);
 max1=max(C);

 E=sort(I_noise(:));
 num=round((rows2*columns2)/2);

 if( (mod(rows2,2)==0) || (mod(columns2,2)==0) )
     median2=(E(num)+E(num+1))/2
    
 else
     median2 = E(num)
 end

 %Calculation of the Mode
 
   D=hist(C,min1:max1);
   D1=find(D==max(D));
   mode2 = D1(1)+min1-1
   
   
%For Histogram eq
  
     %Calculation of the Median

 C=reshape(I_Histo_eq,[],1);
 min1=min(C);
 max1=max(C);

 E=sort(I_Histo_eq(:));
 num=round((rows3*columns3)/2);

 if( (mod(rows3,2)==0) || (mod(columns3,2)==0) )
     median3=(E(num)+E(num+1))/2
    
 else
     median3 = E(num)
 end

 %Calculation of the Mode
 
   D=hist(C,min1:max1);
   D1=find(D==max(D));
   mode3 =D1(1)+min1-1
   
   
  
%For adaptive Histogram
   
 %Calculation of the Median

 C=reshape(I_adaptive,[],1);
 min1=min(C);
 max1=max(C);

 E=sort(I_adaptive(:));
 num=round((rows4*columns4)/2);

 if( (mod(rows4,2)==0) || (mod(columns4,2)==0) )
     median4=(E(num)+E(num+1))/2
    
 else
     median4 = E(num)
 end

 %Calculation of the Mode
 
   D=hist(C,min1:max1);
   D1=find(D==max(D));
   mode4 =D1(1)+min1-1
   
%for Filtered image

 %Calculation of the Median

 C=reshape(I_filt,[],1);
 min1=min(C);
 max1=max(C);

 E=sort(I_filt(:));
 num=round((rows5*columns5)/2);

 if( (mod(rows5,2)==0) || (mod(columns5,2)==0) )
     median5=(E(num)+E(num+1))/2
    
 else
     median5 = E(num)
 end

 %Calculation of the Mode
 
   D=hist(C,min1:max1);
   D1=find(D==max(D));
   mode5 =D1(1)+min1-1
   
  
   
 %Creating the final Matrix
 
 Matrix= [ mean1 mean2 mean3 mean4 mean5; var1 var2 var3 var4 var5;Std_Dev1 Std_Dev2 Std_Dev3 Std_Dev4 Std_Dev5;median1 median2 median3 median4 median5;mode1 mode2 mode3 mode4 mode5]

   

   
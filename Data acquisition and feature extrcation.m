clc;
clear;
close all;

%% Data acquisition and feature extrcation    

%initializing the images and features array
Data = zeros(7,10); %features are rows and images are coloumns

for i=1:10;
x=imread(['DIR' num2str(i) '.jpg']);

x = rgb2gray(x); %converting to one channel
x = double(x); % converting to data type (double)

%statistical features extractions
[rows,columns,Channels] = size(x); 

%Mean extraction (feature 1)
mean = sum(x(:))/(rows*columns); 

%variance extraction (feature 2)
a =(x-mean).^2;
var = sum(a(:))/((rows*columns)-1);

%Standard deviation extraction (feature 3)
std_dev=sqrt(var);


%Median extraction (feature 4)

 C=reshape(x,[],1);
 
 max1=max(C);

 E=sort(x(:));
 num=round((rows*columns)/2);

 if( (mod(rows,2)==0) || (mod(columns,2)==0) )
     median=(E(num)+E(num+1))/2;
    
 else
     median = E(num);
 end
 
 %Mode extraction (feature 5)
 
   D=hist(C,min(C):max(C));
   D=find(D==max(D));
   mode = D(1)+min(C)-1;
   
%skewness extraction (feature 6)   
  sk = skewness(skewness(x));
  
%kurtosis extraction (feature 7)
kur = kurtosis(kurtosis(x)) ;

%filling the matrix of features
Data(1,i)= mean;
Data(2,i)= var;
Data(3,i)= std_dev;
Data(4,i)= median;
Data(5,i)= mode;
Data(6,i)= sk;
Data(7,i)= kur;

end
Data
target  = [0 0 0 0 0 1 1 1 1 1]; % (0) for dogs and (1) for people

%% Data partition

[Train, Test] = crossvalind('HoldOut', target,.4);
Data_train=Data(:,Train)
Data_test=Data(:,Test)
target_train=target(:,Train);
target_test=target(:,Test);
train_index=find(Train==1);
test_index=find(Test==1);
% save Data_train
% save Data_test
% save target_train
% save target_test

 
%% User input
%    [filename, pathname] = uigetfile('*.jpg', 'Select an image');
%     if ~ischar(filename); return; end      %user cancelled
%     filepath = fullfile(pathname, filename);
%     Img = imread(filepath);




%% Classification

% 1. KNN

KNN = fitcknn(Data_train',target_train','NumNeighbors',3); %KNN model
KNN_label = predict(KNN,Data_test');   %predicted labels
    
KNN_CP = classperf(target_test',KNN_label); %Classification performances

%printing the performance
fprintf('KNN Classifier Accuracy: %.2f%%\n',100*KNN_CP.CorrectRate)
fprintf('KNN Classifier Sensitivity: %.2f%%\n',100*KNN_CP.Sensitivity)
fprintf('KNN Classifier Specificity: %.2f%%\n\n\n',100*KNN_CP.Specificity)



% 2. SVM

SVM = fitcsvm(Data_train',target_train');  %SVM  model
SVM_label = predict(SVM,Data_test');       %Perdicted labels
SVM_CP = classperf(target_test',SVM_label);    %Classification performance

%Printing the performnace
fprintf('SVM Classifier Accuracy: %.2f%%\n',100*SVM_CP.CorrectRate)
fprintf('SVM Classifier Sensitivity: %.2f%%\n',100*SVM_CP.Sensitivity)
fprintf('SVM Classifier Specificity: %.2f%%\n\n\n',100*SVM_CP.Specificity)



%3. Naive Bias

Naive = fitcnb(Data_train',target_train');      %Naive Bias model
Naive_label = predict(Naive,Data_test');        %Perdicted labels
Naive_CP = classperf(target_test',Naive_label);  %Classification performance

%Printing the performnace
fprintf('Naive Bias Classifier Accuracy: %.2f%%\n',100*Naive_CP.CorrectRate)
fprintf('Naive Bias Classifier Sensitivity: %.2f%%\n',100*Naive_CP.Sensitivity)
fprintf('Naive Bias Classifier Specificity: %.2f%%\n',100*Naive_CP.Specificity)



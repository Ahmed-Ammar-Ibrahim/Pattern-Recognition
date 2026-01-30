clc;
clear;
close all;
%% Read data
for i=1:10
x=imread(['DIR' num2str(i) '.jpg']);
[rows,columns,Channels] = size(x); 
x = rgb2gray(x);
% standard divation 
input(i,1)=std2(double(x));
% mean 
input(i,2)= mean2(double(x));
% var
a =(x-input(i,2)).^2;
var = sum(a(:))/((rows*columns)-1);
input(i,3) = var;
%Median

 C=reshape(x,[],1);
 
 max1=max(C);

 E=sort(x(:));
 num=round((rows*columns)/2);

 if( (mod(rows,2)==0) || (mod(columns,2)==0) )
     median=(E(num)+E(num+1))/2;
    
 else
     median = E(num);
 end
input(i,4) = median;
% mod 
 D=hist(double(C),min(double(C)):max(double(C)));
 D=find(D==max(D));
  mode = D(1)+min(C)-1;
input(i,5) = mode; 
end
target= [0 0 0 0 0 1 1 1 1 1]';
%% data partition
[Train, Test] = crossvalind('HoldOut', target,.5);  
input=input';
input_train=input(:,Train);
 input_test=input(:,Test);
 target=target';
target_train=target(:,Train);
target_test=target(:,Test);
trainind=find(Train==1);
testind=find(Test==1);
save input_train
save input_test
save target_train
save target_test
%% classification
%% SVM
Training=input_train';
Group=target_train';
Sample=input_test';
testlabel=target_test';
SVMStruct = svmtrain(Training,Group);
Group1 = svmclassify(SVMStruct,Sample);
CP = classperf(testlabel, Group1);
CP.CorrectRate 
CP.Sensitivity 
CP.Specificity 
fprintf('SVM Classifier Accuracy: %.2f%%\n',100*CP.CorrectRate)
fprintf('SVM Classifier Sensitivity: %.2f%%\n',100*CP.Sensitivity)
fprintf('SVM Classifier Specificity: %.2f%%\n',100*CP.Specificity)

%% KNN 
Mdl = fitcknn(Training,Group,'NumNeighbors',3);
%class = fitcknn(Sample, Training, Group,3);
label = predict(Mdl,Sample);
CP = classperf(testlabel,label);
CP.CorrectRate 
CP.Sensitivity 
CP.Specificity 
fprintf('KNN Classifier Accuracy: %.2f%%\n',100*CP.CorrectRate)
fprintf('KNN Classifier Sensitivity: %.2f%%\n',100*CP.Sensitivity)
fprintf('KNN Classifier Specificity: %.2f%%\n',100*CP.Specificity)
%% Naive Bias

Naive = fitcnb(input_train',target_train');      %Naive Bias model
Naive_label = predict(Naive,input_test');        %Perdicted labels
Naive_CP = classperf(target_test',Naive_label);  %Classification performanc

fprintf('Naive Bias Classifier Accuracy: %.2f%%\n',100*Naive_CP.CorrectRate)
fprintf('Naive Bias Classifier Sensitivity: %.2f%%\n',100*Naive_CP.Sensitivity)
fprintf('Naive Bias Classifier Specificity: %.2f%%\n',100*Naive_CP.Specificity)
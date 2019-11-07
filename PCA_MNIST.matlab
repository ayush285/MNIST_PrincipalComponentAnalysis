clear;
close all;
clc;
load('../mnist.mat')

%Multivariate Gaussian fitting for Principal Component Analysis and calculating
%principal modes of variation of handwritten digits using the MNIST dataset.

mean = zeros(784,10);
C = zeros(784,784,10);
dig1 = reshape(digits_test,[784,10000]);
dig1 = double(dig1);
digmu = dig1;
lambda = [0 0 0 0 0 0 0 0 0 0];
V = zeros(784,10);

%img = single(image(digits_test(:,:,1)))
for i = 1:10
    mean(:,i) = sum(dig1(:,labels_test==mod(i,10)),2)/sum(labels_test==mod(i,10));
    digmu = dig1(:,labels_test==mod(i,10)) - mean(:,i);
    C(:,:,i) = (digmu*digmu')/(sum(labels_test==mod(i,10))-1);
    
    e = eig(C(:,:,i));
    figure;
    plot([1:784],sort(e,'descend'));
    title(sprintf("N = %d", mod(i,10)));
    ylabel("eigenvalues")
    [V(:,i),lambda(i)] = eigs(C(:,:,i),1);

    mean1 = uint8(reshape(mean(:,i),[28,28,1]));
    mean2 = uint8(reshape(mean(:,i)-(sqrt(lambda(i))*V(:,i)),[28,28,1]));
    mean3 = uint8(reshape(mean(:,i)+(sqrt(lambda(i))*V(:,i)),[28,28,1]));
    
    figure;
   
    subplot(1,3,2);
    img = image(mean1);
    subplot(1,3,1);
    img = image(mean2);
    subplot(1,3,3);
    img = image(mean3);
    title(sprintf("digit = %d", mod(i,10)));
end






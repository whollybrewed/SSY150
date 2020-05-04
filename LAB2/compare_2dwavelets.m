% code for Task 3
clear all; close all;
clc

input1='frm19.bmp';
input2='frm19_2dwavelets.bmp';
input3='frm19_blkdct.bmp';
iRef=imread(input1);
iCmpr=imread(input2);
iCmpr2=imread(input3);
% compute error
e=abs(iRef-iCmpr);
% compute PSNR
peaksnr=psnr(iCmpr,iRef);
% compute MSSIM
MSSIM=ssim(iCmpr,iRef);

%===================plotting==========================
figure, colormap gray
subplot(2,2,1);
imshow(iRef), title('Original image'); 
subplot(2,2,2);
imshow(iCmpr), title('2D wavelets compression'); 
subplot(2,2,3);
imshow(e*30), title('error * 30');
subplot(2,2,4);
imshow(iCmpr2), title('Block DCT compression'); 


% code for Task 1
clear all; close all;
clc

inputFile='Trees1.avi';
outputFile='frm19_dct.bmp';
% compression ratio
CR=0.98;
[mov,frm]=aviread(inputFile);
% convert frame into image
frmIdx=19;
iRGB=frame2im(mov(frmIdx));
% RGB to grayscale
iGray=rgb2gray(iRGB);
% Normalization, [0 255] -> [0 1]
iRef=mat2gray(iGray);
% 2D DCT
j=dct2(iRef);
% save for plotting
jTemp=j;
% determine threshold and set zeroes  
j=dctmask(j,CR);
% inverse DCT
iCmpr=idct2(j);
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
imshow(jTemp), title('DCT coefficients'); 
subplot(2,2,3);
imshow(iCmpr), title('Compressed image'); 
subplot(2,2,4);
imshow(e*30), title('error * 30');

% imwrite(iGray,outputFile,'bmp');

% hf = figure;
% set(hf,'position',[800 450 vidWidth vidHeight]);
% movie(hf,mov,1,vidObj.FrameRate);



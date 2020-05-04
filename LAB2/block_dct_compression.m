% code for Task 2
clear all; close all;
clc

inputFile='Trees1.avi';
outputFile='frm19_blkdct.bmp';
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
% ==================function handle==================
% block-based DCT
dctblock=@(block_struct)dct2(block_struct.data);
% block-based DCT followed by mask applied 
dctTh=@(block_struct)dctmask(dct2(block_struct.data),CR);
% inverse block-based DCT
invdct=@(block_struct)idct2(block_struct.data);
% ===============8*8 block process===============
% temp saved for plotting
jTemp=blockproc(iRef,[8 8],dctblock);
j=blockproc(iRef,[8 8],dctTh);
iCmpr = blockproc(j,[8 8],invdct);

e=abs(iRef-iCmpr);
peaksnr=psnr(iCmpr,iRef);
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

imwrite(iGray,outputFile,'bmp');


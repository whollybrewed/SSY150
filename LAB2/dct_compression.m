% code for Task 1
clear all; close all;
clc

inputFile='Trees1.avi';
outputFile='frm10.bmp';
% compression ratio
cmprRate=0.98;
% read video file into object
vidObj=VideoReader(inputFile);
vidWidth = vidObj.Width;
vidHeight = vidObj.Height;
% create struct that contains video data
mov=struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
           'colormap',[]);
% read all frames into struct
frm = 1;
while hasFrame(vidObj)
    mov(frm).cdata = readFrame(vidObj);
    frm = frm+1;
end
% convert frame into image
frmIdx=10;
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
th=ceil(cmprRate*size(j,1)*size(j,2));
jVec=j(:);
jSort=sort(abs(jVec));
j(abs(j)<jSort(th))=0;
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
imshow(log(abs(jTemp)),[]), title('logscale DCT'); 
subplot(2,2,3);
imshow(iCmpr), title('Compressed image'); 
subplot(2,2,4);
imshow(e*30), title('error * 30');

% imwrite(iGray,outputFile,'bmp');

% hf = figure;
% set(hf,'position',[800 450 vidWidth vidHeight]);
% movie(hf,mov,1,vidObj.FrameRate);



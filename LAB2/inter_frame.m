% code for Task 5 ~ Task 8
clear all; close all;
clc

inputFile='Trees1.avi';
[mov,frm]=aviread(inputFile);
frmIdx=20;

iRGB=frame2im(mov(frmIdx));
iGray=rgb2gray(iRGB);
iOld=mat2gray(iGray);

iRGB=frame2im(mov(frmIdx+1));
iGray=rgb2gray(iRGB);
iNew=mat2gray(iGray);

th=32/255;
iDiff=abs(iNew-iOld);
for n=1:numel(iDiff)
    if iDiff(n)<th
        iDiff(n)=0;
    end
end
motblock=@(block_struct)motdetect(block_struct.data);
iMot=blockproc(iDiff,[8 8],motblock);

iframe=@(block_struct)motcompens(block_struct.data,iOld,iMot,...
                                 block_struct.location,...
                                 block_struct.blockSize,...
                                 block_struct.imageSize);
i4=blockproc(iNew,[8 8],iframe);
i5=(~iMot.*iOld)+i4;

e=abs(iNew-i5);
peaksnr=psnr(iNew,i5);
MSSIM=ssim(iNew,i5);
%===================plotting==========================
figure, colormap gray
subplot(2,2,1);
imshow(iNew), title('Original image'); 
subplot(2,2,2);
imshow(i4), title('Inter mode MC'); 
subplot(2,2,3);
imshow(i5), title('Reconstructed image'); 
subplot(2,2,4);
imshow(e*30), title('error * 30');

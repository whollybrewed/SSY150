% driver function
clear all; close all;
clc
inputfile='lena.bmp';
img=imread(inputfile);
imgTx=mat2gray(img);
% interleaving option, 1=enable 0=disable
intrlvEnable=1;

% transmitter
dataTx=transmitter(imgTx,intrlvEnable);

% channel (IP network)
% mode1: packet loss, val = loss percentage
% mode2: bit error, val = number of errors per packet
mode=1;
val=0.06;
dataRx=ipchannel(dataTx,mode,val);

% receiver
imgRx=receiver(dataRx,intrlvEnable);

% measurement and plotting
e=abs(imgTx-imgRx);
peaksnr=psnr(imgRx,imgTx);
MSSIM=ssim(imgRx,imgTx);
subplot(1,2,1)
imshow(imgTx);
subplot(1,2,2)
imshow(imgRx);




% driver function
clear all; close all;
clc

inputfile='lena.bmp';
img=imread(inputfile);
imgTx=mat2gray(img);

% transmitter
dataTx=transmitter(imgTx);
% channel (IP network)
dataRx=dataTx;
% receiver
imgRx=receiver(dataRx);

% measurement and plotting
imshowpair(imgTx,imgRx,'montage');
e=imgTx-imgRx;



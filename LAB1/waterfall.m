close all
clear all
clc

[y,Fs] = audioread('MySentence.wav');

ws=100; % block/frame size (10ms->100samples/frame) 
L=floor(length(y)/ws);
figure, hold;
for k=440:460
    seg=y(1+(k-1)*ws:k*ws);
    N=length(seg);
    nfft=10*N;
    wseg=seg.*hamming(N);
    pseg=[wseg;zeros(nfft,1)];
    cep=abs(ifft(log(abs(fft(pseg,nfft)))));
    cep(1)=0;
    c2=cep+k*1; 
    plot(c2(1:nfft/2));
end
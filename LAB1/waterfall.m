% For task 4, pitch estimation through cepstrum
% ----------------------------------------------------
close all; clear all;
clc

[y,Fs] = audioread('MySentence.wav');

ws=100; % block/frame size (10ms->100samples/frame) 
L=floor(length(y)/ws);
figure, hold on;
for k=445:465
    seg=y(1+(k-1)*ws:k*ws);
    N=length(seg);
    nfft=10*N;
    % apply window
    wseg=seg.*hamming(N);
    % zero padding
    pseg=[wseg;zeros(nfft,1)];
    % transform to cepstrum domain
    cep=abs(ifft(log(abs(fft(pseg,nfft)))));
    cep(1)=0;
    c2=cep+k*1; 
    plot(c2(1:nfft/2));
end
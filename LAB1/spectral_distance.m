% For task 5
% ----------------------------------------------------
close all; clear all;
clc

[y,Fs] = audioread('MySentence.wav');
[y2,Fs2] = audioread('syn_MySentence_k20.wav');
L=length(y);
ws=100; % block/frame size (10ms->100samples/frame) 
disto =[];
fHz=(1:1:Fs/2);
rads=fHz.*(2*pi/Fs);
for k=1:ceil(L/ws)
    seg=y(1+(k-1)*ws:k*ws);
    seg2=y2(1+(k-1)*ws:k*ws);
    p=12; %order
    [a,g] = lpc(seg,p);
    [a2,g2] = lpc(seg2,p);
    % compute spectrum
    Ha=freqz(1,a,Fs/2); 
    Ha2=freqz(1,a2,Fs/2); 
    % compare spectra of one frame
    if k==440
        figure(1)
        hold on;
        plot(rads,db(abs(Ha)));
        plot(rads,db(abs(Ha2)));
        xlabel('rad/s');
        ylabel('magnitude(dB)');
        title('power spectrum');
    end
    % find spectral distance
    HH=log(abs(Ha))-log(abs(Ha2)); 
    HH=HH(:)'; 
    seg_disto=(HH*HH')/(Fs/2); 
    disto=[disto,seg_disto];
end
figure(2)
plot(disto);
title('distortion');
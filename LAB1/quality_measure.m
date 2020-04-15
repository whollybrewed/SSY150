close all
clear all
clc

[y,Fs] = audioread('MySentence.wav');
[y2,Fs2] = audioread('syn_MySentence.wav');
L=length(y); % length of audio
ws=100; % block/frame size (10ms->100samples/frame) 

block = 12;

seg=y(1+(block-1)*ws:block*ws);
seg2=y2(1+(block-1)*ws:block*ws);

p=12;
[a,g] = lpc(seg,p);
[a2,g2] = lpc(seg2,p);

[h,w]=freqz(1,a,Fs/2,Fs);
[h2,w2]=freqz(1,a2,Fs/2,Fs);


plot(w,db(abs(h).^2));
plot(w2,db(abs(h2).^2));
% hold on;
% plot(f,db((abs(h)).^2));
% plot(f2,db((abs(h2)).^2));

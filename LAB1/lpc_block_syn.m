% For task 1, Task 2, and Task 3
% ----------------------------------------------------
close all; clear all;
clc

[y,Fs] = audioread('MySentence.wav');
L=length(y); % length of audio
ws=100; % block/frame size (10ms->100samples/frame) 
os=12; % overlap samples

% segmentize the audio, and implement overlap
seg = buffer(y,ws,os);

yOut=[]; % synthesized speech
eOut=[]; % residual signal 

% process frame by frame
for n=1:size(seg,2)
    ySeg = seg(:,n);
    p = 12; %order
    [a,g] = lpc(ySeg,p); % get LPC parameter and error variance
    e = filter(a,sqrt(g),ySeg); %compute error signal
    
    k=ws; % selection threshold
    % keep the largest k residual, and set the rest to zero
    eSel = maxk(e,k,'ComparisonMethod','abs'); 
    for i=1:ws
        if abs(e(i))<abs(eSel(k))
            e(i)=0;
        end
    end
    
    % reconstruct synthesis, using the residule as excitation
    ySyn = filter(sqrt(g),a,e); 
    
    % join frame by frame
    yOut=[yOut,ySyn];
    eOut=[eOut,e];
end
% Overlap-Add
yOut = invbuffer(yOut, os, L);
eOut = invbuffer(eOut, os, L);
audiowrite('syn_MySentence.wav',yOut,Fs);


%--------------------Plotting-------------------------------

% normalize for plotting
y=y/max(abs(y));
yOut=yOut/max(abs(yOut));
eOut=eOut/max(abs(eOut));

figure(1)
subplot(3,1,1);
plot(y);
title('original speech');
subplot(3,1,2);
plot(yOut);
title('synthesis speech');
subplot(3,1,3);
plot(eOut);
title('residual signal');

s1 = 42000; 
s2 = s1+2*ws;
figure(2)
subplot(2,1,1);
plot(s1:s2,y(s1:s2));
title('speech (2 frames)');
subplot(2,1,2);
plot(s1:s2,eOut(s1:s2));
title('residual (2 frames)');



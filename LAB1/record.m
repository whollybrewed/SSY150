close all
clc
clear

%record voice in .wav format

Fs = 10000; %sampling rate
duration = 15; %sec
filename = 'MySentence.wav';

%16 bits/sample, single channel 
recObj = audiorecorder(Fs,16,1); 
disp('Start speaking.')
recordblocking(recObj,duration);
disp('End of Recording.');
myRecording = getaudiodata(recObj);
audiowrite(filename,myRecording,Fs);
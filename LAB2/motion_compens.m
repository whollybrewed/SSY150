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

th=128/255;
iDiff=abs(iNew-iOld);
for n=1:numel(iDiff)
    if iDiff(n)<th
        iDiff(n)=0;
    end
end
motblock=@(block_struct)motdetect(block_struct.data);
iMot=blockproc(iDiff,[8 8],motblock);

% motvec=@(block_struct)findmotvec(block_struct.data,iOld,iMot,...
%                                  block_struct.location,...
%                                  block_struct.blockSize,...
%                                  block_struct.imageSize);
% dvec=blockproc(iNew,[8 8],motvec);

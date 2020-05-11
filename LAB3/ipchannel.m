function dataRx = ipchannel(dataTx,mode,val)
global n
numPac=size(dataTx,1);
pacLen=size(dataTx,2);
% mode 1: packet loss
if mode==1
    numLoss=round(val*numPac);
    lossList=randi(numPac,1,numLoss);
    dataTx(lossList(1:end),:)=zeros(numLoss,pacLen);
end  
% mode 2: bit error
if mode==2
   noise=randi(n,numPac,pacLen).*randerr(numPac,pacLen,val); 
   noise=uint32(round(noise));
   dataTx=bitxor(dataTx,noise);
end
dataRx=dataTx;                        
end
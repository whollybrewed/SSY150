function dataTx = transmitter(imgTx)
global m n k len codebook blksz cut scanOrder
% compression rate
cr=0.5;
% block size
blksz=16;
% number DCT coefficients to stored
cut=round(cr*blksz^2);
% handle function of 2D DCT
dctblock=@(block_struct)dct2(block_struct.data);
% frame-based process
dctCoeff=blockproc(imgTx,[blksz blksz],dctblock);
sig=[];
% zigzag scanning sequence
scanOrder=zzscan(ones(blksz));
% reshape 2D block to 1D sequence
for i=1:blksz:size(dctCoeff,1)
    for j=1:blksz:size(dctCoeff,2)
        tmpBlock=dctCoeff(i:i+blksz-1,j:j+blksz-1);
        tmpVec=[];
        tmpVec=tmpBlock(scanOrder);
        sig=[sig tmpVec(1:cut)];
    end
end
% bits per symbol
m=8;
% codeword length
n=2^m-1;
% message length
k=127;
% signal length
len=size(sig,2);
% upperbound of quantization
upbnd=max(sig);
% lowerbound of quantization
lwbnd=min(sig);
% quantization range
range=upbnd-lwbnd;
% step size
step=range/n;
codebook=(lwbnd:step:upbnd);
% quantization
idx=quantiz(sig,lwbnd:step:upbnd-step,codebook);
% fill zeros at the end of sequence
padsize=k*ceil(len/k)-len;
msg=cat(2,idx,zeros(1,padsize));
% packetization
packet=reshape(msg,k,[])';
% create Galois field arrary
packetGf=gf(packet,m);
% RS encoding
codeword=rsenc(packetGf,n,k);
dataTx=codeword.x;
% interleaving
dataTx=matintrlv(dataTx',51,5)';
end
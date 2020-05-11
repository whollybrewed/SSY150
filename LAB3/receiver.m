function imgRx = receiver(dataRx,intrlvEnable)
global m n k len codebook blksz cut scanOrder
if intrlvEnable==1
    % deinterkleaving
    [Nrows,Ncols]=size(dataRx);
    dataTmp=reshape(dataRx',1,[]);
    dataDeintrlv=matdeintrlv(dataTmp,Nrows,Ncols);
    dataRx=reshape(dataDeintrlv,Ncols,Nrows)';
end
% create Galois field array
dataRxGf=gf(dataRx,m);
% RS decoding
wordRx=rsdec(dataRxGf,n,k);
packetRx=wordRx.x';
% depacketization
msgRx=packetRx(:)';
% removing padded zeros
idxRx=msgRx(1:len);
% restore signal based on codebook
sigRx=codebook(idxRx+1);
dctRx=zeros(256);
win=1;
% reshape 1D sequence to 2D DCT block
for i=1:blksz:size(dctRx,1)
    for j=1:blksz:size(dctRx,2)
        tmpBlock=zeros(blksz);
        seg=[];
        seg=sigRx(win:win+cut-1);
        seg=[seg, zeros(1,blksz^2-cut)];
        tmpBlock(scanOrder)=seg(1:end);
        dctRx(i:i+blksz-1,j:j+blksz-1)=tmpBlock;
        win=win+cut;
    end
end
% handle function of inverse 2D DCT
invdct=@(block_struct)idct2(block_struct.data);
% frame-based process
imgRx=blockproc(dctRx,[blksz blksz],invdct);
end
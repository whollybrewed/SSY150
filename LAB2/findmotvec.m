function dvec = findmotvec(block,iOld,iMot,pos,blksz,imgsz)
    [row,col]=deal(pos(1),pos(2));
    [rowShft,colShft]=deal(blksz(1),blksz(2));
    [height,width]=deal(imgsz(1),imgsz(2));
    if iMot(row,col)==0
        dx=0;
        dy=0;
        dvec=[dy,dx];
        return
    end
    dxstart=1-col;
    dxend=width-col-(colShft-1);
    dystart=1-row;
    dyend=height-row-(rowShft-1);
    minE=realmax;
    for i=dxstart:1:dxend
        for j=dystart:1:dyend
            tempE=immse(block,iOld(row+j:row+j+(rowShft-1),...
                                   col+i:col+i+(colShft-1)));
            if tempE<minE
                minE=tempE;
                dx=-i;
                dy=-j;
            end
        end
    end
    dvec=[dy,dx];
end
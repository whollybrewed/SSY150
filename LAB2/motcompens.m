function i4 = motcompens(block,iOld,iMot,pos,blksz,imgsz)
    [row,col]=deal(pos(1),pos(2));
    [rowShft,colShft]=deal(blksz(1),blksz(2));
    [height,width]=deal(imgsz(1),imgsz(2));
    i4=zeros(rowShft,colShft);
    % only compute motion vector for motion blocks
    if iMot(row,col)==0
        i4(:)=0;
        return
    end
    % compute range of dx and dy
    dxstart=1-col;
    dxend=width-col-(colShft-1);
    dystart=1-row;
    dyend=height-row-(rowShft-1);
    
    minE=realmax;
    % find arg min of dx, dy through global search
    for i=dxstart:dxend
        for j=dystart:dyend
            x=block;
            y=iOld(row+j:row+j+(rowShft-1),...
                   col+i:col+i+(colShft-1));
            tempE=(norm(x(:)-y(:),2).^2)/numel(x);
            if tempE<minE
                minE=tempE;
                dy=j;
                dx=i; 
            end
        end
    end
    % motion compensation
    i4=iOld(row+dy:row+dy+(rowShft-1),...
            col+dx:col+dx+(colShft-1));
end
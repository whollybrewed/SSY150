function dct = dctmask(dct,cmprRate)
    th=ceil(cmprRate*size(dct,1)*size(dct,2));
    dctVec=dct(:);
    dctSort=sort(abs(dctVec));
    dct(abs(dct)<dctSort(th))=0;
end
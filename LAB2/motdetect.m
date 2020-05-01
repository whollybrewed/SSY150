function iMot = motdetect(iDiff)
   iMot=zeros(size(iDiff));
   if sum(abs(iDiff(:)))~=0
       iMot(:)=1;
   else
       iMot(:)=0;
   end
end
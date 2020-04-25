function [mov,frm] = aviread(filename)
    vidObj=VideoReader(filename);
    vidWidth = vidObj.Width;
    vidHeight = vidObj.Height;
    % create struct that contains video data
    mov=struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
               'colormap',[]);
    % read all frames into struct
    frm = 1;
    while hasFrame(vidObj)
        mov(frm).cdata = readFrame(vidObj);
        frm = frm+1;
    end
end
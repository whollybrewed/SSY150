% Source: https://stackoverflow.com/questions/40543989/reverse-buffer-function-in-matlab
% Example:
% % % A = (1:40)';
% % % N_over = 2;
% % % N_window = 15;
% % % L = length(A);
% % % Abuff0 = buffer(A, N_window, N_over);
% % % Abuff = Abuff0(:, 1:end-0);
% % % invbuff = invbuffer(Abuff, N_over, L);
function invbuff = invbuffer(X_buff0, noverlap, L)
invbuff0 = [];
for jj=1:size(X_buff0,2)
    vec00 = X_buff0(:,jj);
    % remove overlapping (or it is zero padding of first frame)
    vec00(1:noverlap) = []; 
    invbuff0 = [invbuff0; vec00];
end
invbuff = invbuff0;
% remove zero padding of last frame
invbuff(L+1:end) = []; 
end
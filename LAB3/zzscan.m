function ind = zzscan(M)
% indices of elements
ind = reshape(1:numel(M), size(M)); 
% get the anti-diagonals
ind = fliplr( spdiags( fliplr(ind) ) );
% reverse order of odd columns
ind(:,1:2:end) = flipud( ind(:,1:2:end) );
% keep non-zero indices
ind(ind==0) = [];                           
end
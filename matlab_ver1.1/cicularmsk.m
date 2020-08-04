% create a circular binary mask
% Not used by 05/20/2020, Hankun
function msk = cicularmsk(x,y,xc,yc,r)
c = zeros(y,x); [L(:,1),L(:,2)] = find(c==0);
L(:,3) = sqrt((L(:,1) - yc).^2 + (L(:,2) - xc).^2);
L(L(:, 3) > r, :) = [];
for i = 1: size(L,1)
   c(y+1-L(i,1),L(i,2)) = 1;
end
msk = imbinarize(c,0);
end
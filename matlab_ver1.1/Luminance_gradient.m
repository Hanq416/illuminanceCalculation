function Luminance_gradient(lmap,cv,name)
lmap(lmap<0) = 0;lumimg = (lmap - min(min(lmap)))/(max(max(lmap))-min(min(lmap)));
if  (1.5<cv)&&(cv<10)
    gm = round(1/cv,2);
elseif cv>10
    gm = 0.09;
else
    gm = 1;
end
lumimg = uint8((lumimg.^gm).*256);
rg = max(max(lmap))-min(min(lmap)); crange = jet(256);crange(1,:) = 0;
cb1 = round(rg.*(0.03316.^(1/gm)),7);cb2 = round(rg.*(0.26754.^(1/gm)),2);
cb3 = round(rg.*(0.50191.^(1/gm)),2);cb4 = round(rg.*(0.73629.^(1/gm)),2);
cb5 = round(rg.*(0.97066.^(1/gm)),2);
figure(2);imshow(lumimg,'Colormap',crange);title(name);
hcb = colorbar('Ticks',[8,68,128,188,248],'TickLabels',{cb1,cb2,cb3,cb4,cb5});
title(hcb,'luminance (cd/m2)');
end
function [IL,LM,MAP] = PerPixel_equidistant(x,y,sx,sy,L)
p_area = sx*sy/10e6/(x*y); cx = max(L(:,1)) - min(L(:,1));
if cx ~= (max(L(:,2)) - min(L(:,2)))
    msgbox('Probe image not aligned!','Error','error');
    error('Error_001: Probe image not aligned!'); return; %#ok<*UNRCH>
end
L(:,4) = sqrt(((abs(L(:,1) - median(L(:,1))) + 0.5)).^2 + ...
    ((abs(L(:,2) - median(L(:,2))) + 0.5)).^2)*(round((sx/x+sy/y)/2,4));
L(:,4) = round(L(:,4)/max(L(:,4))*(cx+1)/2);
for z = 1 : round((cx+1)/2)
    Tref(1,z) = integral(@(z) cos(z).*sin(z), (z-1).*pi/(cx+1), z.*pi/(cx+1));%#ok<*AGROW> 
end
L(:,4) = Tref(L(:,4)).*(pi/(size(L,1)/(max(L(:,1)) - min(L(:,1)))));
MAP = L(:,1:2); MAP(:,3) = L(:,3).*L(:,4);IL = sum(MAP(:,3));
LM = IL*(size(L,1)*p_area);
end
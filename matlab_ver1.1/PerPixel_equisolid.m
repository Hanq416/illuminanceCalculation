%Function for equisolid projection fisheye

%updated 05/20/2020
function [IL,LM,MAP] = PerPixel_equisolid(x,y,sx,sy,f,L)
p_area = sx*sy/10e6/(x*y); cx = max(L(:,1)) - min(L(:,1));
if cx ~= (max(L(:,2)) - min(L(:,2)))
    msgbox('Probe image not aligned!','Error','error');
    error('Error_001: Probe image not aligned!'); return; %#ok<*UNRCH>
end
L(:,4) = sqrt(((abs(L(:,1) - median(L(:,1))) + 0.5)).^2 + ...
    ((abs(L(:,2) - median(L(:,2))) + 0.5)).^2)*(round((sx/x+sy/y)/2,4));
L(:,4) = round(L(:,4)/max(L(:,4))*(cx+1)/2);
for z = 1 : round((cx+1)/2)
    dis = sqrt(((z-0.5).*(sx./x)).^2+(sy./y./2).^2);
    aa(z,1) = 2.*asin(dis./f./2);
end
aa(:,1) = ((pi/2)/max(aa(:,1))).*aa(:,1); ian = 0;
for z = 1 : round((cx+1)/2)
    Tref(1,z) = integral(@(z) cos(z), ian, aa(z,1));%#ok<*AGROW>
    Tref(2,z) = 2.*pi.*(cos(ian) - cos(aa(z,1)));
    % Tref(3,z) = Tref(2,z)./sum(L(:,4)==z)./((pi/2)/round((cx+1)/2));
    Tref(3,z) = Tref(2,z)./sum(L(:,4)==z)./(aa(z,1) - ian);
    ian = aa(z,1);
end
L(:,4) = Tref(1,L(:,4)).*Tref(3, L(:,4));
MAP = L(:,1:2); MAP(:,3) = L(:,3).*L(:,4);IL = sum(MAP(:,3));
LM = IL*(size(L,1)*p_area);
end

%updated 05/18/2020
%{
function [IL,LM,MAP] = PerPixel_equisolid(x,y,sx,sy,f,L)
p_area = sx*sy/10e6/(x*y); cx = max(L(:,1)) - min(L(:,1));
if cx ~= (max(L(:,2)) - min(L(:,2)))
    msgbox('Probe image not aligned!','Error','error');
    error('Error_001: Probe image not aligned!'); return;
end
L(:,4) = sqrt(((abs(L(:,1) - median(L(:,1))) + 0.5)).^2 + ...
    ((abs(L(:,2) - median(L(:,2))) + 0.5)).^2)*(round((sx/x+sy/y)/2,4));
L(:,4) = round(L(:,4)/max(L(:,4))*(cx+1)/2);
for z = 1 : round((cx+1)/2)
    dis = sqrt(((z-0.5).*(sx./x)).^2+(sy./y./2).^2);
    aa(z,1) = 2.*asin(dis./f./2);
end
aa(:,1) = ((pi/2)/max(aa(:,1))).*aa(:,1); sap = 2.*pi/size(L,1);
for z = 1 : round((cx+1)/2)
    if z == 1
        aa(z,2) = aa(z,1) - 0; Tref(1,z) = integral(@(z) cos(z), 0, aa(z,1));
        Tref(2,z) = sap./aa(z,2);
    else
        aa(z,2) = aa(z,1) - aa(z-1,1); Tref(1,z) = integral(@(z) cos(z), aa(z-1,1), aa(z,1));%#ok<*AGROW>
        Tref(2,z) = sap./aa(z,2);
    end
end
L(:,4) = Tref(1,L(:,4)).*Tref(2, L(:,4));
MAP = L(:,1:2); MAP(:,3) = L(:,3).*L(:,4);IL = sum(MAP(:,3));
LM = IL*(size(L,1)*p_area);
end
%}

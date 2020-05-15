%Lux measurement with Radiance HDRi(RGBE)
%Copyright(c)2020 Hankun Li, Hongyi Cai, Siqi He.
%Contact Author: hankunli@ku.edu
%University of Kansas

%Version: 1.0.1
%Update: 05/13/2020

%%%%%%%%%%%%%%%%%%%%%----Warranty Disclaimer----%%%%%%%%%%%%%%%%%%%%%%%%%%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%----INPUT VALUES----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; warning('off'); %#ok<CLALL>
%Camera resolution: 5184*3456 (Canon 500D).
%INFO: Canon 500D sensor's size: width=22.3;height=14.9;(mm)---APSC
sx = 22.3; sy = 14.9; %%% specify camera sensor size ##(INPUT1)##
f = 4.5; %%% specify lens focal length ##(INPUT2)##
x = 0; y = 0; %%% Resolution of your luminance map (.txt) ##(INPUT3)##
%Notes1: Specify resolution of luminance map (.txt) of your HDR image.
%Notes2: If input file is .hdr image, put x and y 0 means using original
%resolution, set x and y can scale the image.
%Notes3: If image resized, x and y must be equally scaled!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file_name = 'sample230lx.hdr'; %%% Input file name here: .hdr or .txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% INITIAL %%%%
[ans1,ans2,ans3] = initial_dialog();
lens_projection = ans1; map_flg = ans2; file_flg = ans3;
%%%% END %%%%

% Main Fucntion:
if file_flg
    L = table2array(readtable(file_name));
    L(L(:, 3) == 0, :) = [];L(:, 3) = L(:, 3)*179;
else
    I = hdrread(file_name); 
    if x*y ~= 0
        I = hdr_resize(I,x,y);
    else
        [y,x] = size(I(:,:,1));
    end
    L = LuminanceRetrieve(I,y);
end
CV = std(L(:,3))/mean(L(:,3)); lux_uni = round(prctile(L(:,3),80)*pi);
if lens_projection
    [lux,lm,map] = PerPixel_equidistant(x,y,sx,sy,L);
else
    [lux,lm,map] = PerPixel_equisolid(x,y,sx,sy,f,L);
end

%Output Values:
fprintf('\n[1]Coefficient of Variation (CV) : %.4f\n', CV);
if CV < 1
fprintf('[1-1]illuminance_(uniform) : %.2f (lux)\n', lux_uni); end
fprintf('\n[2]illuminance_(per-pixel): %.2f (lux)\n', lux);
%fprintf('[3]luminous flux of target scene: %.4f (lumen)\n', lm);
if map_flg
    [luxmap,luximg] = ContriMap(x,y,map,CV);%#ok<*UNRCH>
    roi_opt = yn_dialog('Do you want to get lux of your ROI?');
    if ismember(roi_opt, ['Yes', 'yes'])
        roi_funct(luximg,luxmap); end
    opt2 = yn_dialog('Do you want to check Visulized gradient Map?');
    if ismember(opt2, ['Yes', 'yes'])
        crange = jet(256);crange(1,:) = 0;
        figure;imshow(luximg,'Colormap',crange);
        title('Visulized lux gradient Map (Processed for view only)');
        colorbar('Ticks',[5,250],'TickLabels',{'Low','High'});
    end
end

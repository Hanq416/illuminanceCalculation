%Lux measurement with Radiance HDRi(RGBE)
%Copyright(c)2019-2021 Hankun Li, Hongyi Cai, Siqi He.
%Contact Author: hankunli@ku.edu
%University of Kansas

%Version: 1.0.3
%Update: 06/26/2020

%%%%%%%%%%%%%%%%%%%%%----Warranty Disclaimer----%%%%%%%%%%%%%%%%%%%%%%%%%%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%See the GNU General Public License for more details.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%----INPUT VALUES----%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; warning('off'); %#ok<CLALL>
%Camera resolution: 5184*3456 (Canon 500D).
%INFO: Canon 500D sensor's size: width=22.3;height=14.9;(mm)---APSC
sx = 22.3; sy = 14.9; %%% specify camera sensor size ##(INPUT1)##
f = 4.5; %%% specify lens focal length ##(INPUT2)##
x = 5184; y = 3456; %%% Resolution of your luminance map (.txt) ##(INPUT3)##, no need if input hdr image
%Notes1: Specify resolution of luminance map (.txt) of your HDR image.
%Notes2: If input file is .hdr image, put x and y 0 means using original
%resolution, set x and y can scale the image.
%Notes3: If image resized, x and y must be equally scaled!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file_name = 'VC_hdr07242.hdr'; %%% Input file name here: .hdr or .txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% INITIAL %%%%
[ans1,ans2,ans3,cf,CR] = initial_dialog();
lens_projection = ans1; map_flg = ans2; file_flg = ans3;
fa = yn_dialog('Using Fast method? [No: Accuracy priority.]');
%%%% END %%%%

% Main Fucntion:
if file_flg
    L = table2array(readtable(file_name));
    L(L(:, 3) == 0,:) = [];L(:, 3) = L(:, 3)*179;
else
    I = hdrread(file_name); 
    if CR > 1
        [y,x] = size(I(:,:,1)); x = x/CR; y = y/CR;
        I = hdr_resize(I,x,y);
    else
        [y,x] = size(I(:,:,1));
    end
    L = LuminanceRetrieve(I,y);
end
if cf ~= 0
L = advcf(L,cf);
fprintf('\n[CF] Local calibration factor : %.3f\n', cf);
end
CV = std(L(:,3))/mean(L(:,3)); lux_uni = round(prctile(L(:,3),80)*pi);
if lens_projection
    [lux,lm,map] = PerPixel_equidistant(x,y,sx,sy,L);
else
    if ismember(fa, ['Yes', 'yes'])
        [lux,lm,map] = PerPixel_Fequisolid(x,y,sx,sy,f,L);
    else
        [lux,lm,map] = PerPixel_equisolid(x,y,sx,sy,f,L);
    end
end

%Output Values:
fprintf('\n[1]Coefficient of Variation (CV) : %.4f\n', CV);
if CV < 1
fprintf('[1-1]illuminance_(uniform) : %.2f (lux)\n', lux_uni); end
fprintf('\n[2]illuminance_(per-pixel): %.2f (lux)\n', lux);
fprintf('[3]luminous flux of target scene: %.4f (lumen)\n', lm);
if map_flg
    [luxmap,luximg, lumimap] = ContriMap(x,y,map,CV,L);%#ok<*UNRCH>
    roi_opt = yn_dialog('Do you want to select ROI?');
    if ismember(roi_opt, ['Yes', 'yes'])
        roi_funct(luximg,luxmap,lumimap); end
    opt2 = yn_dialog('Do you want to check gradient Map?');
    if ismember(opt2, ['Yes', 'yes'])
        crange = jet(256);crange(1,:) = 0;
        figure;imshow(luximg,'Colormap',crange);
        title('Visulized luminance gradient map (with cosine correction)');
        colorbar('Ticks',[8,128,248],'TickLabels',{'Low','Medium','High'});
    end
    opt3 = yn_dialog('check luminance map without cosine?');
    if ismember(opt3, ['Yes', 'yes'])
        Luminance_gradient(lumimap,CV,'Luminance geadient map(without cosine correction)'); 
    end
end
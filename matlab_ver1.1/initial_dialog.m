function [ans1,ans2,ans3,cf,CR] = initial_dialog()
prompt = {'Your fisheyelens projection     [0: equisolid, 1: equidistant]',...
    'illuminance map and ROI selection? [SKIP: 0, YES: 1]',...
    'Type of input file?    [image(.hdr): 0, luminance(.txt): 1]',...
    'Need local CF calibration? [SKIP: 0, or INPUT calibration factor]',...
    'Compress hdr image? [No: 1, or INPUT compression rate]'};
dlgtitle = 'User Input'; dims = [1 50];definput = {'0','0','0','0','1'};
answer = str2double(inputdlg(prompt,dlgtitle,dims,definput));
if isempty(answer)
    ans1 = 0; ans2 = 0; ans3 = 0; cf = 0; CR = 1;
else
    ans1 = answer(1); ans2 = answer(2); ans3 = answer(3);
    cf = answer(4); CR = answer(5);
end
end
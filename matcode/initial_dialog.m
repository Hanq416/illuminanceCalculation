function [ans1,ans2,ans3] = initial_dialog()
prompt = {'Your fisheyelens projection     [0: equisolid, 1: equidistant]',...
    'illuminance map and ROI selection? [SKIP: 0, YES: 1]',...
    'Type of input file?    [image(.hdr): 0, luminance(.txt): 1]'};
dlgtitle = 'User Input'; dims = [1 35];definput = {'0','0','0'};
answer = str2double(inputdlg(prompt,dlgtitle,dims,definput));
if isempty(answer)
    ans1 = 0; ans2 = 0; ans3 = 0;
else
    ans1 = answer(1); ans2 = answer(2); ans3 = answer(3); 
end
end
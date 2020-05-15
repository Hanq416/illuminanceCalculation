function [roi_lux,prct,ROI] = hdr_roi(luximg,luxmap)
%Instruction: select your roi and finished by double-click
figure(1);ROI = roipoly(luximg);close(gcf);lookup = []; 
if isempty(ROI)
    msgbox('No ROI selected!','Error','error'); close(gcf);
    error('Error_003: no ROI selected, try again!'); return; %#ok<*UNRCH>
end
[lookup(:,2),lookup(:,1)] = find(ROI);
for i = 1:size(lookup,1)
    lux_sel(i) = luxmap(lookup(i,2),lookup(i,1));%#ok<*AGROW> 
end
roi_lux = sum(lux_sel); prct = roi_lux/sum(sum(luxmap));
end
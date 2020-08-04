function roi_funct(luximg,luxmap,lumimap)
roi_c = 1; 
while true
    [roi_lux,prct,roimask] = hdr_roi(luximg,luxmap);
    lroi = lumimap.*roimask; lumi=mean(mean(lroi(lroi>0)));
    fprintf('ROI_#%d \n',roi_c);
    fprintf('[-]Average luminance of selected ROI: %.3f (cd/m2)\n',lumi);
    fprintf('[-]lux of selected ROI: %.6f (lx)\n',roi_lux);
    fprintf('[-]ratio of lux contribution from ROI: %.8f\n', prct);
    h_roi = roimask.*double(luximg); roi_img=h_roi + double(luximg)./2;
    figure(100+roi_c);imshow(uint8(roi_img),'InitialMagnification',50);
    title('Your ROI of the scene');movegui('east');
    cflg = yn_dialog('Select next ROI?');roi_c = roi_c+1;
    if ~ismember(cflg, ['Yes', 'yes'])
        break; end
end
end
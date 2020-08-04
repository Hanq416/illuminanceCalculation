function L = advcf(L,cf)
ig = 98.5; th = prctile(L(:,3),ig); ulim = prctile(L(:,3),99.5);
while true
if (ulim/th < 20) && (ulim/th > 5)
    break;
elseif ulim/th < 5
    ig = ig - 0.25; th = prctile(L(:,3),ig);
        if ig == 85
        error('Error_004: Calibration not successed!\n'); break; 
        end
elseif ulim/th > 20
    ig = ig + 0.1; th = prctile(L(:,3),ig);
    if ig == 99
        error('Error_004: Calibration not successed\n'); break; 
    end
end
end
L(L(:, 3) < th, 3) = L(L(:, 3) < th, 3).*cf;
end
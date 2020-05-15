function eml = EMLRetrieve(I,y)
R = I(:,:,1); G = I(:,:,2); B = I(:,:,3); eml = [];
Lraw = (R.*0.0013 + G.*0.3812 + B.*0.6475).*179; %EML
[eml(:,2),eml(:,1)]=find(Lraw);
for i = 1:size(eml,1)
    eml(i,3) = Lraw(eml(i,2),eml(i,1));
end
eml(:,2) = y - eml(:,2);
end
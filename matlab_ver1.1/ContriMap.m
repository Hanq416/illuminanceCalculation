function [luxmap,luximg,lumimap] = ContriMap(x,y,map,cv,L)
luxmap = zeros(y,x); lumimap = zeros(y,x);
for i = 1: size(map,1)
   luxmap(y+1-map(i,2),map(i,1)) = map(i,3);
   lumimap(y+1-L(i,2),L(i,1)) = L(i,3);
end
luxmap(luxmap<0) = 0;
luximg = (luxmap - min(min(luxmap)))/(max(max(luxmap))-min(min(luxmap)));
if  (1.5<cv)&&(cv<10)
    gm = round(1/cv,2);
elseif cv>10
    gm = 0.09;
else 
    gm = 1;
end
luximg = uint8((luximg.^gm).*256);
end

function [luxmap,luximg] = ContriMap(x,y,map,cv)
luxmap = zeros(y,x);
for i = 1: size(map,1)
   luxmap(y+1-map(i,2),map(i,1)) = map(i,3);
end
luximg = (luxmap - min(min(luxmap)))/(max(max(luxmap))-min(min(luxmap)));
if  (1.5<cv)&& (cv<10)
    luximg = uint8((luximg.^(round(1/cv,2))).*256);
elseif cv>10
    luximg = uint8((luximg.^(0.09)).*256);
else 
    luximg = uint8(luximg.*256);
end
end

function out = hdr_resize(I,x,y)
[m,n] = size(I(:,:,1));
if n/x == m/y
    out = imresize(I,x/n);
else
    msgbox('x and y not equal scaled!','Error','error');
    error('Error_002: Input resolution not correct!'); return;
end
end
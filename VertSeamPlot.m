function x=VertSeamPlot(x,SeamVector)
% SEAMPLOT takes as input an image and the SeamVector array and produces
% an image with the seam line superimposed upon the input image, x, for
% display purposes.
%

s=size(SeamVector)
value=1.5*max(x(:));
for j=1:s(2)
    for i=1:length(SeamVector)
        x(i,SeamVector(i,j))=value;
    end
end


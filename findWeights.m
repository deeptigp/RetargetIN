function binImage=findWeights(origImage)
     bw=rgb2gray(origImage);
%     binImage=im2bw(bw,0.7);
%     return
%     % If background is not black, invert the image
%     if(binImage(1,1)~=0)
%         binImage=1-binImage;
%     end
%     binImage=binImage*3;

    binImage=zeros(size(bw));
end
   
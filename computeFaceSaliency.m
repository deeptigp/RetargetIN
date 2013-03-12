function weight=computeFaceSaliency(inputFile)
 %Assume you have [ x,y,width, height]
 [files faces]= parseFaceCoordinates();
  %files
 %1: Compute Center and radius
 [flag index]=ismember(inputFile,files);
 inp=imread(inputFile);
 sz=size(inp);
 weight=zeros(sz(1),sz(2) );     
 if(flag==1)
   %[faces(index,2) faces(index,2)+faces(index,4)]
   center =[ faces(index,2)+(faces(index,4))/2.0 faces(index,3)+(faces(index,5))/2.0 ];
     %2 Add a weight of 10 in those detected pixels - check if that improves
   weight(faces(index,2):faces(index,2)+faces(index,4),faces(index,3):faces(index,3)+faces(index,5))=50;
    %result.
 end
    %2 compute saliency value as shown in the paper
    %3include that and test
end
function x=HorSeamCut(x,SeamVector)
[rows cols dim]=size(x);
[SVrows SVcols SVdim]=size(SeamVector);
%[1 640 3]
if cols~=SVcols
    error('SeamVector and image dimension mismatch');
end
%CutImg=zeros(rows,cols-1,dim);
for k=1:SVrows              %goes through set of seams
    for i=1:dim             %if rgb, goes through each channel
        for j=1:cols        %goes through each row in image
            if SeamVector(k,j)==1
                CutImg(:,j,i)=[x(2:rows,j,i)];
            elseif SeamVector(k,j)==rows
                CutImg(:,j,i)=[x(1:rows-1,j,i)];
            else
                CutImg(:,j,i)=[x(1:SeamVector(k,j)-1,j,i); x(SeamVector(k,j)+1:rows,j,i)];
            end
        end
    end
     x=CutImg;
    clear CutImg
    [rows cols dim]=size(x);
end
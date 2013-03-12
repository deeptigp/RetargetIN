function x=VertSeamCut(debug,x,SeamVector)
[rows cols dim]=size(x);
[SVrows SVcols SVdim]=size(SeamVector);

if rows~=SVrows
    error('SeamVector and image dimension mismatch');
end
%CutImg=zeros(rows,cols-1,dim);
for k=1:SVcols              %goes through set of seams
    for i=1:dim             %if rgb, goes through each channel
        for j=1:rows        %goes through each row in image
            %clear CutImg
            if SeamVector(j,k)==1
                CutImg(j,:,i)=[x(j,2:cols,i)];
            elseif SeamVector(j,k)==cols
                CutImg(j,:,i)=[x(j,1:cols-1,i)];
            else
                %SeamVector(j,k)
                a=[x(j,1:SeamVector(j,k)-1,i) x(j,SeamVector(j,k)+1:cols,i)];
                if(debug==1)
                    disp('size of a')
                    sz=size(a) 
                    if(sz==555)
                        disp('sz==555')
                        SeamVector(j,k)
                    end
                end
                CutImg(j,:,i)=[x(j,1:SeamVector(j,k)-1,i) x(j,SeamVector(j,k)+1:cols,i)];
                if(debug==1)
                disp('size of cutimg')
                size(CutImg(j,:,i))
                end
            end
        end
    end
    x=CutImg;
    [rows cols dim]=size(x);
end
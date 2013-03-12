function x=HorSeamPut(debug,x,SeamVector)
[rows cols dim]=size(x);
[SVrows SVcols SVdim]=size(SeamVector);
%[1 640 3]
if cols~=SVcols
    error('SeamVector and image dimension mismatch');
end
%PutImg=zeros(rows,cols-1,dim);
for k=1:SVrows              %goes through set of seams
    for i=1:dim             %if rgb, goes through each channel
        for j=1:cols        %goes through each row in image
           % disp('seamvector')
           % SeamVector(k,j)
            if SeamVector(k,j)==1
                if(debug)
                    disp('if 1')
                    a=[x(1,j,i); x(1:rows,j,i)];
                    size(a)
                end
                PutImg(:,j,i)=[x(1,j,i); x(1:rows,j,i)];    
            elseif SeamVector(k,j)==rows
                if(debug)
                    disp('if 2')
                    a=[x(1:rows,j,i); x(rows,j,i)];
                    size(a)
                end
                PutImg(:,j,i)=[x(1:rows,j,i); x(rows,j,i)];
            else
                if(debug)
                    disp('if 3')
                    a=[x(1:SeamVector(k,j),j,i); 1/2*(x(SeamVector(k,j),j,i)+x(SeamVector(k,j)+1,j,i)) ; x(SeamVector(k,j)+1:rows,j,i)];
                    size(a)
                end
                PutImg(:,j,i)=[x(1:SeamVector(k,j),j,i); 1/2*(x(SeamVector(k,j),j,i)+x(SeamVector(k,j)+1,j,i)) ; x(SeamVector(k,j)+1:rows,j,i)];
            end
         %   break;
        end
    end
     x=PutImg;
    clear PutImg
    [rows cols dim]=size(x);
end
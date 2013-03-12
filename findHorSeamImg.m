function HSeamImg=findHorizontalSeamImg(x,W)
% FINDSEAMIMG finds the seam map from which the optimal (vertical running) 
% seam can be calculated. Input is gradient image found from findEnergy.m.
%
% The indexing can be interpreted as in this example image:
%   [(i-1,j-1)  (i-1,j)  (i-1,j+1)]
%   [(i,j-1)    (i,j)    (i,j+1)  ]
%   [(i+1,j-1)  (i+1,j)  (i+1,j+1)]
%

[rows cols]=size(x);
HSeamImg=zeros(rows,cols);
HSeamImg(:,1)=x(:,1)+W(:,1);

for j=2:cols
    for i=1:rows
        if i-1<1
            HSeamImg(i,j)= x(i,j)+W(i,j)+min([HSeamImg(i,j-1),HSeamImg(i+1,j-1)]);
        elseif i+1>rows
            HSeamImg(i,j)= x(i,j)+W(i,j)+min([HSeamImg(i-1,j-1),HSeamImg(i,j-1)]);
        else
            HSeamImg(i,j)= x(i,j)+W(i,j)+min([HSeamImg(i-1,j-1),HSeamImg(i,j-1),HSeamImg(i+1,j-1)]);
        end
    end
    %HSeamImg(:,j)
    %return
end

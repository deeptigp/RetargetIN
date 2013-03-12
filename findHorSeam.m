function [SeamVector,seamEnergy]=findHorSeam(x,flag)
% FINDSEAM returns a column vector of coordinates for the pixels to be
% removed (the seam), given the SeamImage resulting from findSeamImg.m
% each element "j" of SeamVector is the column number of the pixel in 
% row i to be removed.
%

[rows cols]=size(x);
seamEnergy=0;
for i=cols:-1:1
    if i==cols
        ab=x(:,cols);
        ba=ab(length(ab):-1:1);
        if(flag)
        [value, j]=min(ab);  %finds min value of last column and the row index
        else
         [value, j]=min(ba);  %finds min value of last column and the row index
         j=length(ab)-j+1;
        end
        seamEnergy=seamEnergy+value;
    else    %accounts for boundary issues
        if SeamVector(1,i+1)==1
            Vector=[Inf x(SeamVector(i+1),i) x(SeamVector(i+1)+1,i)];
        elseif SeamVector(1,i+1)==rows
            Vector=[x(SeamVector(i+1)-1,i) x(SeamVector(i+1),i) Inf];
        else
            Vector=[x(SeamVector(i+1)-1,i) x(SeamVector(i+1),i) x(SeamVector(i+1)+1,i)];
        end
        %% yet to fix
        %find min value and index of 3 neighboring pixels in prev. row.
        [Value Index]=min(Vector);
        %Value,Index
        IndexIncrement=Index-2;
        j=SeamVector(1,i+1)+IndexIncrement;
        seamEnergy=seamEnergy+Value;
    end
    SeamVector(1,i)=j;
end
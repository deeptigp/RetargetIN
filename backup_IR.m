function [OrigImage]=backup_IR(face,debug,imgFile,tarRows,tarCols)
    sTime=cputime;
    OrigImage=imread(imgFile);
    OrigImage=double(OrigImage)/255;
    [orgRows orgCols dim]=size(OrigImage);
    %Number of vertical seams to form and remove
    colDiff=orgCols-tarCols;
    rowDiff=orgRows-tarRows;
    if(face)
        Weight=computeFaceSaliency(imgFile);
    else
        Weight=findWeights(OrigImage);
    end
   % imshow(double(Weight)/255);
        E1=findEnergy(OrigImage);
%        disp('energy');
     %E1
     %return
    if(abs(rowDiff)>0)
        for i=1:abs(rowDiff)
       %     i
              %Energy map for the Horizontal Seam
            H1=findHorSeamImg(E1,Weight);
            %return
            %Find horizontal Seam
            HorSeamVector(i,:) = findHorSeam(H1,rem(i,2)); 
            if(debug)
              %  disp('size of H1')
               % size(H1)
               % imshow(H1,[min(H1(:)) max(H1(:))])
               % disp('HorseamVector')
               % size(HorSeamVector)
            end
            if(rowDiff>0)
                OrigImage=HorSeamCut(OrigImage,HorSeamVector(i,:));
                E1=HorSeamCut(E1,HorSeamVector(i,:));
                Weight=HorSeamCut(Weight,HorSeamVector(i,:));
            elseif(rowDiff<0)              
                OrigImage=HorSeamPut(debug,OrigImage,HorSeamVector(i,:));
                E1=HorSeamPut(debug,E1,HorSeamVector(i,:));
                Weight=HorSeamPut(debug,Weight,HorSeamVector(i,:));
            end
            [orgRows orgCols dim]=size(OrigImage);
        end
    end
    
    %E1=findEnergy(OrigImage);
    %Weight=findWeights(OrigImage);
    
    if(abs(colDiff)>0)
        for i=1:abs(colDiff)
            E1=findEnergy(OrigImage);
        %    size(E1)
         %   size(Weight)
            S1=findVertSeamImg(E1,Weight);
            %Find vertical Seam
            VertSeamVector(:,i)=findVertSeam(S1,rem(i,2));  
          %  if(rem(i,2)==1)
           %     VertSeamVector(:,i)=abs(orgCols-VertSeamVector(:,i));
           % end
            %VertSeamVector;
            if(colDiff>0)
                OrigImage=VertSeamCut(debug,OrigImage,VertSeamVector(:,i));
                E1=VertSeamCut(debug,E1,VertSeamVector(:,i));
                Weight=VertSeamCut(debug,Weight,VertSeamVector(:,i));
            elseif(colDiff<0)
                OrigImage=VertSeamPut(OrigImage,VertSeamVector(:,i));
                E1=VertSeamPut(E1,VertSeamVector(:,i));
                Weight=VertSeamPut(Weight,VertSeamVector(:,i));
            end
            [orgRows orgCols dim]=size(OrigImage);
            if(debug)
                figure(2)
                imshow(S1,[min(S1(:)) max(S1(:))])
                figure(3)
                imshow(VertSeamedImg,[min(VertSeamedImg(:)) max(VertSeamedImg(:))])
                figure(4)
                imshow(OrigImage)
            end
            %return
        end
    end
%      HorSeamedImg=HorSeamPlot(E1,HorSeamVector);
%      figure('horSeam');
%      imshow(HorSeamedImg,[min(HorSeamedImg(:)) max(HorSeamedImg(:))])
%      figure('vertSeam');
%      VertSeamedImg=VertSeamPlot(E1,VertSeamVector);
%      imshow(VertSeamedImg,[min(VertSeamedImg(:)) max(VertSeamedImg(:))])  
      cputime-sTime
end
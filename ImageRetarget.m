function [OrigImage]=ImageRetarget(face,debug,imgFile,tarRows,tarCols)
    sTime=cputime;
    OrigImage=imread(imgFile);
    OrigImage=double(OrigImage)/255;
    [orgRows orgCols dim]=size(OrigImage);
    %Number of vertical seams to form and remove
    colDiff=orgCols-tarCols;
    rowDiff=orgRows-tarRows;
    totalSeams=abs(colDiff)+abs(rowDiff);
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
    
    horSeamCount=0;
    verSeamCount=0;
    while((abs(rowDiff)>0 || abs(colDiff)>0) && (horSeamCount+verSeamCount <=totalSeams))    
        horSeamEnergy=100000;
        verSeamEnergy=100000;
        %(colDiff+rowDiff)
          if(abs(rowDiff)>0)
            H1=findHorSeamImg(E1,Weight);
            [currHorSeam,horSeamEnergy] = findHorSeam(H1,rem(horSeamCount,2)); 
          end
          
          if(abs(colDiff)>0)
          S1=findVertSeamImg(E1,Weight);
          [currVerSeam, verSeamEnergy]=findVertSeam(S1,rem(verSeamCount,2));  
          end
          
          %verSeamEnergy,horSeamEnergy
          if(horSeamEnergy < verSeamEnergy)
              % remove or add horizontal Seam
              horSeamCount=horSeamCount+1;
             % disp('horSeamCount');
             % disp(horSeamCount);
              %HorSeamVector(horSeamCount,:)=currHorSeam;
              if(rowDiff>0)
                OrigImage=HorSeamCut(OrigImage,currHorSeam);
                E1=HorSeamCut(E1,currHorSeam);
                Weight=HorSeamCut(Weight,currHorSeam);
              elseif(rowDiff<0)              
                OrigImage=HorSeamPut(debug,OrigImage,currHorSeam);
                E1=HorSeamPut(debug,E1,currHorSeam);
                Weight=HorSeamPut(debug,Weight,currHorSeam);
              end
          else
              %remove or add vertical seam
              verSeamCount=verSeamCount+1;
              %disp('verSeamCount');
              %disp(verSeamCount);
              %currVerSeam=currVerSeam;
              if(colDiff>0)
                OrigImage=VertSeamCut(debug,OrigImage,currVerSeam);
                E1=VertSeamCut(debug,E1,currVerSeam);
                Weight=VertSeamCut(debug,Weight,currVerSeam);
             elseif(colDiff<0)
                OrigImage=VertSeamPut(OrigImage,currVerSeam);
                E1=VertSeamPut(E1,currVerSeam);
                Weight=VertSeamPut(Weight,currVerSeam);
            end
          end %if
          [orgRows orgCols dim]=size(OrigImage);
          colDiff=orgCols-tarCols;
          rowDiff=orgRows-tarRows;
    end %while
%      
%     if(abs(rowDiff)>0)
%         for i=1:abs(rowDiff)
%        %     i
%             %Energy map for the Horizontal Seam
%             H1=findHorSeamImg(E1,Weight);
%             HorSeamVector(i,:) = findHorSeam(H1,rem(i,2)); 
%             if(debug)
%               %  disp('size of H1')
%                % size(H1)
%                % imshow(H1,[min(H1(:)) max(H1(:))])
%                % disp('HorseamVector')
%                % size(HorSeamVector)
%             end
%             if(rowDiff>0)
%                 OrigImage=HorSeamCut(OrigImage,HorSeamVector(i,:));
%                 E1=HorSeamCut(E1,HorSeamVector(i,:));
%                 Weight=HorSeamCut(Weight,HorSeamVector(i,:));
%             elseif(rowDiff<0)              
%                 OrigImage=HorSeamPut(debug,OrigImage,HorSeamVector(i,:));
%                 E1=HorSeamPut(debug,E1,HorSeamVector(i,:));
%                 Weight=HorSeamPut(debug,Weight,HorSeamVector(i,:));
%             end
%             [orgRows orgCols dim]=size(OrigImage);
%         end
%     end
%     
%     %E1=findEnergy(OrigImage);
%     %Weight=findWeights(OrigImage);
%     
%     if(abs(colDiff)>0)
%         for i=1:abs(colDiff)
%             S1=findVertSeamImg(E1,Weight);
%             %Find vertical Seam
%             VertSeamVector(:,i)=findVertSeam(S1,rem(i,2));  
%           %  if(rem(i,2)==1)
%            %     VertSeamVector(:,i)=abs(orgCols-VertSeamVector(:,i));
%            % end
%             %VertSeamVector;
%             if(colDiff>0)
%                 OrigImage=VertSeamCut(debug,OrigImage,VertSeamVector(:,i));
%                 E1=VertSeamCut(debug,E1,VertSeamVector(:,i));
%                 Weight=VertSeamCut(debug,Weight,VertSeamVector(:,i));
%             elseif(colDiff<0)
%                 OrigImage=VertSeamPut(OrigImage,VertSeamVector(:,i));
%                 E1=VertSeamPut(E1,VertSeamVector(:,i));
%                 Weight=VertSeamPut(Weight,VertSeamVector(:,i));
%             end
%             [orgRows orgCols dim]=size(OrigImage);
%             if(debug)
%                 figure(2)
%                 imshow(S1,[min(S1(:)) max(S1(:))])
%                 figure(3)
%                 imshow(VertSeamedImg,[min(VertSeamedImg(:)) max(VertSeamedImg(:))])
%                 figure(4)
%                 imshow(OrigImage)
%             end
%             %return
%         end
%     end
%      HorSeamedImg=HorSeamPlot(E1,HorSeamVector);
%      figure('horSeam');
%      imshow(HorSeamedImg,[min(HorSeamedImg(:)) max(HorSeamedImg(:))])
%      figure('vertSeam');
%      VertSeamedImg=VertSeamPlot(E1,VertSeamVector);
%      imshow(VertSeamedImg,[min(VertSeamedImg(:)) max(VertSeamedImg(:))])  
      cputime-sTime
end
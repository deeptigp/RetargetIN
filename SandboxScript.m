% Script file for experimenting with various seam functions
%
% Author: Danny Luong, 12/5/07

close all
clear all
X=imread('whistler.jpg');
X=double(X)/255;
[rows cols dim]=size(X);

%get hsv image
Y=rgb2hsv(X);

%     figure(1)
%     imagesc(X)
%     axis equal

%find gradient image of luminance channel
E1=findEnergy(X);

    %figure(2)
    %imshow(E1)
    %imsave()
    

%     
% E1=zeros(300,500);
% E1(120,:)=1;

%finds seam calculation image
S1=findSeamImg(E1);

    figure(4)
    imshow(S1,[min(S1(:)) max(S1(:))])
    imwrite(S1,'seam-image','*.jpg');
    %imsave(S1,[min(S1(:)) max(S1(:))])
    
% Finds seam    
SeamVector=findSeam(S1);

%plot image with superimposed seam
SeamedImg=SeamPlot(E1,SeamVector);
    %figure
    imshow(SeamedImg,[min(SeamedImg(:)) max(SeamedImg(:))])
    imwrite(SeamedImg,'seamplot','*.jpg');

%remove seam
SeamCutImg=SeamCut(X,SeamVector);

    %figure
    imshow(SeamCutImg)
    imwrite(SeamCutImg,'seamcutimg','*.jpg');
%find and remove N seams
[M,I]=removalMap(X,cols);
MSeamedImg=SeamCut(X,M);
% figure
% imshow(MSeamedImg)


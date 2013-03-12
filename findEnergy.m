function Emean=findEnergy(x)
% FINDENERGY creates an gradient img from a given RGB or grayscale image.
% The vertical and horizontal gradients are found using a Sobel operator
% and the gradient magnitude is found for each channel and averaged if RGB
% image is input.

[rows cols dim]=size(x);
%sobel operator used to calculate gradient image
Grd=[ -1 -2 -1;
       0  0  0;
       1  2  1];

Emean=zeros(rows,cols);
for i=1:dim
    Eh(:,:,i)=conv2(x(:,:,i),Grd,'same');
    Ev(:,:,i)=conv2(x(:,:,i),Grd.','same');
    E(:,:,i)=abs(Eh(:,:,i))+abs(Ev(:,:,i));

end
Emean=1/dim*sum(E,3);   %finds average gradient image if RGB image
%Emean=edge(rgb2gray(x),'prewitt');
%Emean=edge(rgb2gray(x),'canny');
%imshow(Emean);
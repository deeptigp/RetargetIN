function [files,faces] = parseFaceCoordinates()
    d=importdata('face_coordinates.txt');
    files=d.textdata;
    faces=d.data;
end
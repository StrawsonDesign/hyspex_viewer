function [bands, width, lines, wavelengths] = hyspex_file_details(file)
    %This function reads out an image for the spescified band
    fid = fopen(file,'rb');
    start = fread(fid,8,'uchar');
    %Check if it is a HySpex file
    if (start(1:8) == [72;89;83;80;69;88;0;0])
        %Read header information
        %size of binary header
        size = fread(fid,1,'int32');
        fseek(fid,1949,'cof');
        %number of spectral channels
        bands = fread(fid,1,'int32');
        %number of spatial pixels
        width = fread(fid,1,'int32');
        fseek(fid,4*26,'cof');
        %number of lines in image
        lines = fread(fid,1,'int32');
        % wavelength vector
        fseek(fid,2169+12,'bof');
        wavelengths = fread(fid,bands,'double');
    else
        warning('Not a HySpex file');
        return;
    end
    fclose(fid);
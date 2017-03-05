function f = band_from_hyspex(file,bandnumber)
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
        spectral = fread(fid,1,'int32');
        %number of spatial pixels
        spatial = fread(fid,1,'int32');
        fseek(fid,4*26,'cof');
        %number of lines in image
        number = fread(fid,1,'int32');
        fseek(fid,2169+12,'bof');
        %spectral vector
        %spec = fread(fid,spectral,'double');
        fseek(fid,size,'bof');
        f = zeros(spatial,number);
        if (bandnumber > spectral)
            warning('The band number is larger than the number of bands in the file');
            return;
        else
            for i = 1:number
                if (i == 1) fseek(fid,spatial*(bandnumber-1)*2,'cof');
                else
                    fseek(fid,(spectral-1)*spatial*2,'cof');
                end
                f(:,i) = fread(fid,spatial,'uint16');
            end
        end
        else
        warning('Not a HySpex file');
        return;
    end
    fclose(fid);
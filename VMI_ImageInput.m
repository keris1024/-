function [Img_Out] = VMI_ImageInput(FolderPath,FileName,ImageFormat,SerialNUM)

for i = 1:length(SerialNUM)
    %merge actrally file path
    Img_path = [FolderPath '\' FileName num2str(SerialNUM(i)) ImageFormat];
    switch ImageFormat
        case '.raw'
            %get data of raw
            fid1 = fopen(Img_path,'r','l');
            % Read width and height
            [ImgWidth] = fread(fid1,1,'uint32');
            [ImgHeight] = fread(fid1,1,'uint32');
            ImgBitDepthFormat = 'uint32';
            Img_Out = double(zeros([ImgWidth ImgHeight]));
            fclose(fid1);
        otherwise
            if(i<=1)
                %get data of pic
                ImgInfo = imfinfo(Img_path);
                ImgWidth = ImgInfo.Width;
                ImgHeight = ImgInfo.Height;
                ImgBitDepth = ImgInfo.BitDepth;
                if ImgBitDepth == 32
                    ImgBitDepthFormat = 'uint32=>double';
                    Img_Out = double(zeros([ImgWidth ImgHeight]));
                elseif ImgBitDepth == 16
                    ImgBitDepthFormat = 'uint16=>double';
                    Img_Out = double(zeros([ImgWidth ImgHeight]));
                else
                    ImgBitDepthFormat = 'uint8=>double';
                    Img_Out = double(zeros([ImgWidth ImgHeight]));
                end
            end
    end

    %open file to get data of pixel
    ImgHandle = fopen (Img_path, 'r','l');
    %open Image with data
    Img_R = fread(ImgHandle, [ImgWidth ImgHeight], ImgBitDepthFormat);
    %release opened file
    fclose(ImgHandle);
    %accumulate data
    Img_Out = Img_Out + Img_R;
end


function [ImgWidth,ImgHeight,ImgBitDepth] = VMI_ImageBasicInfo(FolderPath,FileName,ImageFormat,SerialNUM)
 %merge actrally file path   
 Img_path = [FolderPath '\' FileName num2str(SerialNUM) ImageFormat];
 switch ImageFormat
     case '.raw'
         %get data of raw
         fid1 = fopen(Img_path,'r','l');
       % Read width and height
        [ImgWidth] = fread(fid1,1,'uint32');
        [ImgHeight] = fread(fid1,1,'uint32');
        ImgBitDepth = 32;
     otherwise
         %get data of pic
         ImgInfo = imfinfo(Img_path);
         ImgWidth = ImgInfo.Width;
         ImgHeight = ImgInfo.Height;
         ImgBitDepth = ImgInfo.BitDepth;
 end
end


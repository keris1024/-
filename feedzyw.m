close all 
clear all
cd 'C:\Users\Keris\Desktop\st'

SignalFolder ='C:\Users\Keris\Desktop\st';
BackgroundFolder =SignalFolder;

ImageName = 'CCD Image ';
ImageFormat = '.tiff';
Img_Serial = [5];
Bg_Serial = [];
CaxisPara = [400 1000];
 
%parameterSet
WidthCentre = 227;%X
HeightCentre = 245;%Y
DigitalPerAngle = 1/16;
RadiusOfSignal = 400;%245
angularmin= 230;
angularmax= 240;
TransedSignal = 'on';%平移图像到中心
FilterSignal = 'on';%对图像进行中值滤波
FilterShowSignal = 'off';%显示中值滤波对比
RotateSignal = 'on';%旋转图像
RotateDegree = 10;%旋转角度
CompressedSignal = 'off';%压缩图像
CompressPara = 1;%压缩比
InverseSignal = 'on';%折叠以图像一半构建新的图像
InversePara = ["up"];%图像一半来源位置,可多次迭代对称, left right up down
ClearCentreSignal = 'off';%去除图像中心部分信号并填充随机背景
ClearCentreRadius = 150;%中心定义为半径以内
ClearValueRadius = 230;%均值参考定义半径环
AuxMidLineSD = 'off';%显示图像中心辅助参考
AuxCirSD = 180;%显示图像中心圆参考
PRthetaAuxLineSignal = 'off';%沿半径扫描图片辅助线显示
AuxLinePoiSET = [0 0 0 0];%沿半径扫描图片参考线
PRthetaAuxPlotSignal = 'off';%沿半径方向扫描辅助判断
AssymetrySignal = 'off';%平衡信号图像左右权重
CompareCom_InvSignal = 'off';%显示网格曲面图对比
C_RawImage = 'display';
C_TransedImage = 'display';
C_RotatedImage = 'display';

C_Inversed_PET_Image = 'display';
C_DeCentre_Image = 'Ndisplay';
C_ReInversedImage = 'display';
C_ReInversed_PET_Image = 'display';

C_Le_LogReversed_Image = 'display';
C_Le_PE_Image = 'display';
C_Le_Waterfall_Image = 'display';

[ImgWidth,ImgHeight,ImgBitDepth] = VMI_ImageBasicInfo(SignalFolder,ImageName,ImageFormat,Img_Serial(1));
%get data of pic
Img_Data = VMI_ImageInput(SignalFolder,ImageName,ImageFormat,Img_Serial);
if(isempty(Bg_Serial))
    Img_BG = zeros(ImgWidth,ImgHeight);
else
    Img_BG = VMI_ImageInput(BackgroundFolder,ImageName,ImageFormat,Bg_Serial);
end

figure;
imagesc(Img_Data,[400 1000])

PRtheta = VMI_PRthetaCount(Img_Data, ImgWidth, ImgHeight, DigitalPerAngle,RadiusOfSignal);
% calculate the radial distribution with respect to the angle of ejected
% electron

% first, you have to choose the good center, when you look at PRtheta,
% all contribution should give a line in this figure, otherwise, the
% center is not goodtalPerAngle,RadiusOfSignal);
VMI_ToShow(PRtheta,'PRtheta','Degree/digital','R',CaxisPara,'PRtheta',DigitalPerAngle,AuxLinePoiSET,'c',0.75)
figure
suptitle('PRthetaAuxPlot')
subplot(1,2,1)
plot(sum(PRtheta))
subplot(1,2,2)
plot(sum(PRtheta,2))

VMI_AngularDistribution(PRtheta,angularmin,angularmax);
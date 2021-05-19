function NPEtheta = VMI_PRthetaCount(ImgInput,ImgWidth,ImgHeight,StepLength,Rmax)
% calculate the radial distribution with respect to the angle of ejected electron
  
% first, you have to choose the good center, when you look at PEtheta, all
% contribution should give a line in this figure, otherwise, the center is
% not good
XCenter=ImgHeight/2;
YCenter=ImgWidth/2;

NPEtheta = double(zeros(Rmax,360/StepLength));
    for R=1:Rmax
        NewXpoi=0;
        for thetaScan=1:StepLength:361
            NewXpoi=NewXpoi+1;
            if R<Rmax
                NPEtheta(R,NewXpoi)=ImgInput(round(YCenter+R*cos(thetaScan*pi/180)),round(XCenter+R*sin(thetaScan*pi/180)));
            else
                NPEtheta(R,NewXpoi)=0;
            end
        end
    end
end

function [ ] = VMI_ToShow(varargin)
%draw pics with unify format
% the parameter is differ from PEpic and normal pi;for PEpic, auxline can
% be defined from 1xN martix with a series value and same color;for normal
% auxline is formed by a circal in middle and a crossline in
% middle.caxispara range from 0->1, which is percent of max value of pic

[ImgInput, TitlePic, TitleMain, TitleSub, CaxisPara] = varargin{1:5};
switch varargin{6}
    case('PRtheta')
        DrawType = 'PRtheta';
        [StepLength,AuxLinePoi,DrawLineColor,DrawLineWidth] = varargin{7:10};
    case('Normal')
        DrawType = 'Normal';
        [AuxCir,DrawLineColor,DrawLineWidth,DrawCirColor,DrawCirWidth]=varargin{7:11};
    case('PEtheta')
        DrawType = 'PEtheta';
        [X_Axis,Y_Axis,AuxLinePoi,DrawLineColor,DrawLineWidth] = varargin{7:11};
    otherwise
        DrawType = 'Off';
end

if((strcmpi(varargin{nargin},'Ndisplay'))~= 1)
    ImageColorMap=jet(256);
    ImageColorMapSelected=find(ImageColorMap(:,3)==1);
    ImageColorMapSelected=ImageColorMapSelected(10);
    ImageColorMap(1:ImageColorMapSelected,:)=[zeros(ImageColorMapSelected,2) linspace(0,1,ImageColorMapSelected)'];
    
    switch DrawType
        case('PRtheta')
            figure
            imagesc(ImgInput)
            if(length(CaxisPara) == 1)
                colormap(ImageColorMap)
                caxis([0 max(max(ImgInput))*CaxisPara]);
                shading interp
                colorbar
            else
                colormap('jet')
                caxis([CaxisPara(1),CaxisPara(2)]);
                shading interp
                colorbar
            end
            
            xlabel(['\it{' TitleMain  '}'], 'fontsize',15);
            ylabel(['\it{' TitleSub  '}'], 'fontsize',15);
            title(TitlePic,'fontsize',15)
            set(gca,'fontsize',15)
            axis square
            
            hold on
            
            PlotNum = 360/StepLength;
            xticks([0 PlotNum/4 PlotNum/4*2 PlotNum/4*3 PlotNum])
            xticklabels({0,90,180,270,360})
            
            if(AuxLinePoi ~= 0)
                hold on
                for DrawLinePoi = AuxLinePoi
                    plot([0 PlotNum],[DrawLinePoi DrawLinePoi],'Color',DrawLineColor,'LineWidth',DrawLineWidth)
                end
            end
        case('PEtheta')
            figure
            pcolor(X_Axis,Y_Axis,ImgInput)
            if(length(CaxisPara) == 1)
                colormap(ImageColorMap)
                caxis([0 max(max(ImgInput))*CaxisPara]);
                shading interp
                colorbar
            else
                colormap(ImageColorMap)
                caxis([CaxisPara(1),CaxisPara(2)]);
                shading interp
                colorbar
            end
            
            xlabel(['\it{' TitleMain  '}'], 'fontsize',15);
            ylabel(['\it{' TitleSub  '}'], 'fontsize',15);
            title(TitlePic,'fontsize',15)
            set(gca,'fontsize',15)
            set(gca,'YDir','reverse');
            axis square
            
            
            PlotNum = length(X_Axis);
            if(AuxLinePoi ~= 0)
                hold on
                for DrawLinePoi = AuxLinePoi
                    plot([0 PlotNum],[DrawLinePoi DrawLinePoi],'Color',DrawLineColor,'LineWidth',DrawLineWidth)
                end
            end
        case('Normal')
            figure
            imagesc(ImgInput)
            if(length(CaxisPara) == 1)
                colormap(ImageColorMap)
                caxis([0 max(max(ImgInput))*CaxisPara]);
                shading interp
                colorbar
            else
                colormap(ImageColorMap)
                caxis([CaxisPara(1),CaxisPara(2)]);
                shading interp
                colorbar
            end
            
            xlabel(['\it{' TitleMain  '}'], 'fontsize',15);
            ylabel(['\it{' TitleSub  '}'], 'fontsize',15);
            title(TitlePic,'fontsize',15)
            set(gca,'fontsize',15)
            axis square
            
            hold on
            [MWidth,Mheight]=size(ImgInput);
            if(strcmp(DrawLineColor,'N') ~= 1)
                plot([0 Mheight],[MWidth/2 MWidth/2],'Color',DrawLineColor,'LineWidth',DrawLineWidth)
                plot([Mheight/2 Mheight/2],[0 MWidth],'Color',DrawLineColor,'LineWidth',DrawLineWidth)
            end
            if(AuxCir ~= 0)
                viscircles([Mheight/2 MWidth/2],AuxCir,'Color',DrawCirColor,'LineWidth',DrawCirWidth);
            end
        otherwise
            figure
            imagesc(ImgInput)
            if(length(CaxisPara) == 1)
                colormap(ImageColorMap)
                caxis([0 max(max(ImgInput))*CaxisPara]);
                shading interp
                colorbar
            else
                colormap('jet')
                caxis([CaxisPara(1),CaxisPara(2)]);
                shading interp
                colorbar
            end
            
            xlabel(['\it{' TitleMain  '}'], 'fontsize',15);
            ylabel(['\it{' TitleSub  '}'], 'fontsize',15);
            title(TitlePic,'fontsize',15)
            set(gca,'fontsize',15)
            axis square
    end
end
end



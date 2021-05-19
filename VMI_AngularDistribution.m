function [ ] = VMI_AngularDistribution(ExperimentsData,poi_S,poi_E)
%UNTITLED5 此处显示有关此函数的摘要
costheta = -1:0.01:1;
thetac=(0:359).*(pi/180);
costhetac=cos(thetac);

ExperimentsRange = (poi_S:poi_E);
ExperimentsData(:,1:101)=fliplr(ExperimentsData(:,101:201));

figure
polarplot(acos(costheta(1:201)),sum(ExperimentsData(ExperimentsRange,1:201),1)/max(sum(ExperimentsData(ExperimentsRange,1:201),1)),':r','LineWidth',2.5)
hold on
polarplot(acos(costheta(1:201)),-sum(ExperimentsData(ExperimentsRange,1:201),1)/max(sum(ExperimentsData(ExperimentsRange,1:201),1)),':r','LineWidth',2.5);

hold on

end


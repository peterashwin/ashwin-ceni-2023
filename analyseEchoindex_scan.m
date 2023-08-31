%
%  analyse echo index scans
%
%  PA and AC
%  Aug 2023


%% Start with a clean slate
clear all
close all

%% OPTIONAL: TURN OFF WARNINGS
%warning('off','all')
%warning
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
printfigs=true;

%% load generating parameter and data
% make and save figures

%% 
name='modelA';
load(sprintf('..//Data//%s.mat',name));
fno=1;
makefigure(p1,p2,nc,fno);
title(sprintf('$T=%d$ $p_0=%f$ $p_1=%f$',ps.tmax,pu.pp),'interpreter', 'latex');
savefigure(name,fno,printfigs)

%% 
name='modelB';
load(sprintf('..//Data//%s.mat',name));
fno=2;
makefigure(p1,p2,nc,fno);
title(sprintf('$T=%d$ $p_0=%f$ $p_1=%f$',ps.tmax,pu.pp),'interpreter', 'latex');
savefigure(name,fno,printfigs)

%% 
name='modelC';
load(sprintf('..//Data//%s.mat',name));
fno=3;
makefigure(p1,p2,nc,fno);
title(sprintf('$T=%d$ $p_0=%f$ $p_1=%f$',ps.tmax,pu.pp),'interpreter', 'latex');
savefigure(name,fno,printfigs)

%% 
name='modelD';
load(sprintf('..//Data//%s.mat',name));
fno=4;
makefigure(p1,p2,nc,fno);
title(sprintf('$T=%d$ $p_0=%f$ $p_1=%f$',ps.tmax,pu.pp),'interpreter', 'latex');
savefigure(name,fno,printfigs)

%% 
name='modelE';
load(sprintf('..//Data//%s.mat',name));
fno=5;
makefigure(p1,p2,nc,fno);
title(sprintf('$T=%d$ $p_0=%f$ $p_1=%f$',ps.tmax,pu.pp),'interpreter', 'latex');
savefigure(name,fno,printfigs)

%% 
name='modelF';
load(sprintf('..//Data//%s.mat',name));
fno=6;
makefigure(p1,p2,nc,fno);
title(sprintf('$T=%d$ $p_0=%f$ $p_1=%f$',ps.tmax,pu.pp),'interpreter', 'latex');
savefigure(name,fno,printfigs)


keyboard;


%% 
function makefigure(p1,p2,nc,fno)
% Make figure
f1=figure(fno);
clf;
f1.Position(3:4)=[450 330];
pcolor(p1,p2,nc');
xlabel('$m_{0}^-$','Interpreter', 'latex');
ylabel('$m_{1}^+$','Interpreter', 'latex');
ncols=max(max(nc));
mymap=colormap('lines');
colormap(mymap(1:ncols,:))
cb=colorbar;
cb.TicksMode='manual';
cb.Limits=[0.5 ncols+0.5];
cb.Ticks=[1:ncols];
cb.TickLabelInterpreter='latex';

end

%%
function savefigure(name,number,printfigs)
% Save figure(number) as f-name-number.pdf/.png if printfigs==true
%
ffname = sprintf('..//Figures//fig-%s', name);
h=figure(number);
set(h,'Units','centimeters');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
if(printfigs==true)
    %savefig(sprintf('%s.fig',ffname));
    print(sprintf('%s.pdf',ffname),'-dpdf');
    %print(sprintf('%s.png',ffname),'-dpng');
end
end
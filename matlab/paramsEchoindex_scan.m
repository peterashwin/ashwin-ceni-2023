%% parameters for echo index scan
% Aug 2023

%% simulation params
ps.name='dummy';
% simulation time
ps.tmax=100;
% simulate jmax trajectories
ps.jmax=50;
% plot from jmin
ps.jmin=1;
% cutoff for clustering
ps.cutoff=0.05;

%% parameters for generating input sequences
% probability of repeating current symbol after min repeats
pu.pp=[0.9 0.95];
% minimum repeats of symbol
pu.mm=[3 1];
% maximum repeats of symbol
pu.mp=[40 5];

%% params for map Galpha
pg.Wr=[0.5, 0; 0, 1.75];
pg.Win=[1, 0; 0, 1];
pg.uin=[0.25, -0.25; 0.05, -0.5];
pg.alpha=0.25;

%% default
pps(1)=ps;
ppu(1)=pu;
pps(1).name='modelA';

%  change tmax
pps(2)=ps;
ppu(2)=pu;
pps(2).tmax=500;
pps(2).name='modelB';

%  change tmax
pps(3)=ps;
ppu(3)=pu;
pps(3).tmax=2000;
pps(3).name='modelC';

%  change pu.pp(2)
pps(4)=ps;
ppu(4)=pu;
pps(4).tmax=500;
pps(4).name='modelD';
ppu(4).pp=[0.9 0.99];

%  change pu.pp(1)
pps(5)=ps;
ppu(5)=pu;
pps(5).tmax=1000;
pps(5).name='modelE';
ppu(5).pp=[0.5 0.9];

%  change pu.pp(1)
pps(6)=ps;
ppu(6)=pu;
pps(6).tmax=1000;
pps(6).name='modelF';
ppu(6).pp=[0.0 1.0];

nop=6;

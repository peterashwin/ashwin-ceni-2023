%%
%  echo index scans
%  save in ../Data/
%
%  PA and AC
%  Aug 2023


%% Start with a clean slate
clear all
close all

% random number generator
rng('default')
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

%% load parameter sets
run('paramsEchoindex_scan.m');

%% run for each parameter set
for i=1:nop
    % load parameters
    ps=pps(i);
    pu=ppu(i);
    Wr=pg.Wr;
    Win=pg.Win;
    uin=pg.uin;
    alpha=pg.alpha;
    %
    sprintf('working on %s',ps.name)
    % generate random input
    u1=1;
    T=ps.tmax;
    ui=randinput(u1,pu,T);

    %% figure with example trajectories
    %
    figure();
    %
    for j=1:ps.jmax
        x0=2*rand(2,1)-[1;1];
        xx=zeros(2,ps.tmax);
        xx(:,1)=x0;
        for t=2:T
            xx(:,t)=Galpha(xx(:,t-1),ui(t),Wr,Win,uin,alpha);
        end
        plot(xx(1,ps.jmin:end),xx(2,ps.jmin:end),'*')
        hold on;
        xend(:,j)=xx(:,end);
    end
    hold off;
    xx=xend';
    clu=clusterdata(xx,'Criterion','distance','Cutoff',ps.cutoff);
    nc=max(clu);
    ncc=histcounts(clu);

    %%
    % scan through range of m_1^- and m_2^+
    tic
    p1max=40;
    p2max=40;
    p1=[1:p1max];
    p2=[1:p2max];
    nc=zeros(p1max,p2max);
    nc1=zeros(p1max,p2max);
    nc2=zeros(p1max,p2max);
    for i=p1
        
        for j=p2
            % set varying input params
            pu.mm(1)=i;
            pu.mp(2)=j;
            % generate random input
            u1=1;
            ui=randinput(u1,pu,T);
            % generate jmax trajectories
            % final point in xend
            xend=zeros(2,ps.jmax);
            for k=1:ps.jmax
                x0=2*rand(2,1)-[1;1];
                xx=zeros(2,T);
                xx(:,1)=x0;
                for t=2:ps.tmax
                    xx(:,t)=Galpha(xx(:,t-1),ui(t),Wr,Win,uin,alpha);
                end
                xend(:,k)=xx(:,T);
            end
            %% now look for clusters
            xx=xend';
            clu=clusterdata(xx,'Criterion','distance','Cutoff',ps.cutoff);
            nc(i,j)=max(clu);
            ncc=histcounts(clu);
            nc1(i,j)=ncc(1);
            if nc(i,j)>1
                nc2(i,j)=ncc(2);
            end
        end
    end


    %% Saving
    path = '../Data/';
    name = ps.name;
    file_name = [path name];

    save( [file_name '.mat'], 'pu', 'ps', 'p1', 'p2', 'nc', 'nc1', 'nc2', 'pg');
end


keyboard;




%%
%
function temp=Galpha(x,i,Wr,Win,uin,alpha)
t2=Wr*x+Win*uin(:,i);
temp=(1-alpha)*x+alpha*tanh(t2);
end

%% generate input sequence length T starting at y0 with params pu
%
function U=randinput(U0,pu,T)
U=zeros(1,T);
U(1)=U0;
i=2;
reps=[0 0];
while i<=T
    u=U(i-1);
    reps(u)=reps(u)+1;
    if reps(u)>pu.mm(u)
        if reps(u)>=pu.mp(u)
            % reached maximum repeats so switch symbol
            u=3-u;
            reps(u)=0;
        else
            if rand>pu.pp(u)
                % more than min, less than max so switch with probability
                % 1-pp(u)
                u=3-u;
                reps(u)=0;
            end
        end
    end
    U(i)=u;
    i=i+1;
end
end

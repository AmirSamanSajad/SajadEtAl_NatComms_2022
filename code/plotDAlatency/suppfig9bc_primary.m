%% Dependencies
% This script requires the following external toolboxes to run:
% - GRAMM (https://github.com/piermorel/gramm)
% For simplicity, this has been included in the _utils folder.

%% Data input
% Load in neuron maps (/index) for each class within our paper:
load(fullfile(dataFolder,'suppfig9b_SEFclasses.mat'))

% Load in processed latency estimates of our neuron classes:
load(fullfile(dataFolder,'suppfig9b_SEFlatencies.mat'))

% and those provided kindly by Ogasawara et al., 2018 of latencies in the
% VTA/SN and Caudate in monkeys performing the same saccade countermanding
% task
load(fullfile(dataFolder,'suppfig9b_DAlatency.mat'))

%% Calculate CDF for each neuron class latency
% From Ogasawara et al., (2018)
%  VTA/SN neurons:
VTA_CDF = SEF_Toolbox_CumulativeDistribition(SSRTaligned_latency.DA,'-',2,[1,0,0] , 0);
%  Caudate (increase/decrease) neurons:
CaudateIncrease_CDF = SEF_Toolbox_CumulativeDistribition(SSRTaligned_latency.CD_IncreaseType,'-',2,[1,0,0] , 0);
CaudateDecrease_CDF = SEF_Toolbox_CumulativeDistribition(SSRTaligned_latency.CD_DecreaseType,'-',2,[1,0,0] , 0);

% From this current paper (2022)
%  Conflict neurons:
SEFconflict_CDF = SEF_Toolbox_CumulativeDistribition(spk_ModulationTiming.reSSRT.differenceFunction.Conflict.onset,'-',2,[1,0,0] , 0);
%  Goal maintenance neurons:
SEFgoal_CDF = SEF_Toolbox_CumulativeDistribition(spk_ModulationTiming.reSSRTbeest.differenceFunction.GoalMaintenance.onset,'-',2,[1,0,0] , 0);
%  Event timing neurons:
SEFtiming_CDF = SEF_Toolbox_CumulativeDistribition(spk_ModulationTiming.reSSRTbeest.differenceFunction.EventTiming.onset,'-',2,[1,0,0] , 0);

%% Get estimates of the mesocortical latency
% First, we estimated the mesocortical distance by plotting the pathway
% from SN/VTA to the MFC using a section from the RH12 data set on
% brainmaps.org. Details are in text.
mesocorticalDistance = (21.14781*2640)/1000;

% We then used estimates of the conduction velocity of DA neurons,
% estimated across several previous studies including:
mesocorticalLatency1 = mesocorticalDistance / 0.54; % Grace & Bunney (1980)
mesocorticalLatency2 = mesocorticalDistance / 0.55; % Thierry et al., (1980)
mesocorticalLatency3 = mesocorticalDistance / 0.58; % Guyenet et al., (1978)
mesocorticalLatency4 = mesocorticalDistance / 0.55; % Deniau et al., (1978)
% to get an estimate of latency (time = distance/speed)

% We can then average over all these estimates to get a grand average to
% use
mesocorticalLatencyMean = mean([mesocorticalLatency1,...
    mesocorticalLatency2, mesocorticalLatency3, mesocorticalLatency4]);

%%  Estimate VTA -> MFC signal propagation time
% After estimating the time it takes for a signal to get to SEF from VTA,
% we can then add this latency to the latencies observed in VTA to get an
% estimate of what time we could expect signals in SEF.
VTA_AdditionalLatency_CDF = [VTA_CDF(:,1)+mesocorticalLatencyMean,...
    VTA_CDF(:,2)];

%% Produce figure
% Input all of the relevant data into one array for use in the gramm
% toolbox. Here, we are putting in the the latencies for each neuron class
% and their corresponding CDF value.
latencyArray = [VTA_CDF; VTA_AdditionalLatency_CDF;...
    CaudateIncrease_CDF; CaudateDecrease_CDF;...
    SEFconflict_CDF; SEFgoal_CDF; SEFtiming_CDF];

% For gramm, we will then also give each of these observations a label, to
% match the data to the neuron class it came from.
labels = [repmat({'DA'},length(VTA_CDF),1);...
    repmat({'DA + Latency'},length(VTA_CDF),1);
    repmat({'Caudate_Facilited'},length(CaudateIncrease_CDF),1);
    repmat({'Caudate_Suppressed'},length(CaudateDecrease_CDF),1);
    repmat({'SEF_Conflict'},length(SEFconflict_CDF),1);
    repmat({'SEF_Goal'},length(SEFgoal_CDF),1);
    repmat({'SEF_Timing'},length(SEFtiming_CDF),1)];

% We then input this data into gramm
clear latencyFigure
latencyFigure(1,1)=gramm('x',latencyArray(:,1),'y',latencyArray(:,2),'color',labels);
% ...producing a line graph (standard for CDFs)
latencyFigure(1,1).geom_line();
% ...with labeled axes
latencyFigure(1,1).set_names('x','Time from SSRT (ms)','y','Fraction of units');

% We then ask gramm to draw the figure
figure('Position',[100 100 600 300]);
latencyFigure.draw();

%% Output data for statistical analysis
% To determine if modualtion latencies are significantly earlier/later between classes
% we will output the latency values into a CSV file, for analysis in JASP.

latencyTable = table(latencyArray(:,1),labels,'VariableNames',{'Latency','NeuronType'});
writetable(latencyTable,fullfile(mainFolder,'analysis','suppfig_9c','jasp_sefvta_latency.csv'),'WriteRowNames',true) 

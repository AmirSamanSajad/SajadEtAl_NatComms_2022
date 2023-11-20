%% Housekeeping
% Load in processed behavioral data from across all sessions. This
% executiveBeh structure houses information about SSDs, pNC, trial indices
% (ttx, ttm), neuron mappings, and event times. 
load(fullfile(dataFolder,'beh','executiveBeh.mat'))

%% Set parameters for race setup
% We first define the type of interactive race model we would like to run:
% boosted fixation, or blocked input (Logan et al., 2015). In this paper,
% we have run with boosted fixation, although results are qualitatively
% similar between models.
modelRunFlag = 'boosted'; % or blocked

% We then provide information about the temporal structure of the trial we
% would like to generate. Here, we are running from -100 to 800 ms relative
% to a target (GO process onset).
trial.time = [-100:800]; trial.length = length(trial.time); trial.targOn_time = find(trial.time == 0); 

% Alongside these variables, we will also set parameters for the race
% models. These can be manipulated within this function. This function will
% output parameters that have been previously derived (Logan et al., 2015) 
% for each type of interactive race model.
[interactiveRaceParam, blockedInputParam, boostedFixParam] = getModelParameters('monkeyC');

%% Run race models
% Given that we have all the parameters and details defined above, we can
% now look to run simulations of the model.

% Here, we take take the input of the model that the user would like
% (modelRunFlag), setup the input/parameters to the function, and then run
% it. Currently, there are three models that can be run:
switch modelRunFlag
    % Standard interactive race model:
    case {'interactive'}
        param = interactiveRaceParam.param; % Get parameters
        trialDetails = interactiveModel(param, trial); % Run race
    % Boosted-fixation interactive race 2.0 model:
    case {'boosted'}
        param = boostedFixParam.param; % Get parameters
        trialDetails = boostedFixModel(param, trial); % Run race
    % Blocked-input interactive race 2.0 model:
    case {'blocked'}
        param = blockedInputParam.param; % Get parameters
        trialDetails = blockedInputModel(param, trial); % Run race
end


%% Derive simulation stopping behavior
% Once we have run the simulations and got trial by trial details of the
% simulation (trialDetails), we can then use these to determine what
% stopping behavior would be.

% We start by extracting stopping behaviour (SSDs, pNC, nTrs, inhibition
% function fits, etc...) and estimating SSRT.
[stopBehTable, SSRT] = getRaceStoppingBeh(param, trialDetails);
% We then can generate estimates of conflict within particular windows of
% interest. In this paper, we used EXPAND.
[SSDconflict] = getRaceConflict(param, trial, trialDetails, stopBehTable, SSRT);

%% Produce conflict figure
% Set up figure parameters
SSD_figIdx = [1,4]; % We will plot the 1st, 2nd, and 4th SSD's.
getColors % This script simply provides RGB values for different conditions

% Create the figure object
figure('Renderer', 'painters', 'Position', [100 100 1200 600]); 

% We will produce the figure for two stop-signal delays. For each SSD we
% present the co-activation/conflict (middle column). We will also show
% behavior generated through the simulation.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%### Stop-signal delay (50 ms) ################################
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get trials for the first SSD presented.
clear trials_SSD1 conflictTime; 
trials_SSD1 = stopBehTable.trials_canceled{SSD_figIdx(1)};

% Generate the subplot
subplot(2,3,1); hold on
% For each trial:
for ii = 1:length(trials_SSD1)
    trlIdx = trials_SSD1(ii); % Get the trial index
    % Get the values of co-activation between movement (trialMoveAccum) * fixation (trialFixAccum) accumulators.
    conflictTime(ii,:) = trialDetails.trialMoveAccum{trlIdx}.*trialDetails.trialFixAccum{trlIdx};    
    % ... then plot this co-activation.
    conflictTimePlot = plot(trial.time,conflictTime(ii,:),'color',colors.noncanc);
    % and then make these 5% transparent, as we are plotting A LOT.
    conflictTimePlot.Color(4) = 0.05; conflictTimePlot.Color(4) = 0.05;
end
% Then we can plot the mean accumulator across all trials
conflictTimePlot_mean = plot(trial.time,nanmean(conflictTime),'color',colors.noncanc,'LineWidth',2);


% Tidy the figure, placing vertical lines (as detailed above):
vline(0,'k-'); vline(param.SSD(SSD_figIdx(1)),'k--'); vline(param.SSD(SSD_figIdx(1))+SSRT.integrationWeighted,'b')
% ... and label the axes appropriately
xlim([-100 500]); xlabel('Time from Target (ms)'); ylabel('Conflict (a.u.)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%### Stop-signal delay (200 ms) ###############################
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get trials for the first SSD presented.
clear trials_SSD2 conflictTime; 
trials_SSD2 = stopBehTable.trials_canceled{SSD_figIdx(2)};

% Generate the subplot
subplot(2,3,3); hold on
% For each trial:
for ii = 1:length(trials_SSD2)
    trlIdx = trials_SSD2(ii); % Get the trial index
    % Get the values of co-activation between movement (trialMoveAccum) * fixation (trialFixAccum) accumulators.
    conflictTime(ii,:) = trialDetails.trialMoveAccum{trlIdx}.*trialDetails.trialFixAccum{trlIdx};    
    % ... then plot this co-activation.
    conflictTimePlot = plot(trial.time,conflictTime(ii,:),'color',colors.noncanc);
    % and then make these 5% transparent, as we are plotting A LOT.
    conflictTimePlot.Color(4) = 0.05; conflictTimePlot.Color(4) = 0.05;
end
% Then we can plot the mean accumulator across all trials
conflictTimePlot_mean = plot(trial.time,nanmean(conflictTime),'color',colors.noncanc,'LineWidth',2);


% Tidy the figure, placing vertical lines (as detailed above):
vline(0,'k-'); vline(param.SSD(SSD_figIdx(2)),'k--'); vline(param.SSD(SSD_figIdx(2))+SSRT.integrationWeighted,'b')
% ... and label the axes appropriately
xlim([-100 500]); xlabel('Time from Target (ms)'); ylabel('Conflict (a.u.)');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%### Response latency CDF #####################################
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the CDF for non-canceled and no-stop response latencies.
clear SSD_NC_RTcdf SSD_GO_RTcdf NCrt
NCrt = trialDetails.RT(trialDetails.stopTrialFlag==1);
SSD_NC_RTcdf{1} = SEF_Toolbox_CumulativeDistribition(NCrt(~isnan(NCrt)));
SSD_GO_RTcdf{1} = SEF_Toolbox_CumulativeDistribition(trialDetails.RT(trialDetails.stopTrialFlag==0));

subplot(2,3,4); hold on
% Plot the CDF for non-canceled response latencies.
plot(SSD_NC_RTcdf{1}(:,1),SSD_NC_RTcdf{1}(:,2),'k--','LineWidth',1)
% Plot the CDF for no-stop response latencies.
plot(SSD_GO_RTcdf{1}(:,1),SSD_GO_RTcdf{1}(:,2),'color',[0 0 0 1],'LineWidth',1)
% ...and label the axes!
xlabel('Response Latency (ms)'); ylabel('CDF')
legend({'Non-canceled','No-Stop'},'Location','Southeast')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%### Inhibition function ######################################
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,3,5); hold on
% Produce a scatter plot with points showing the p(respond|SSD) at each SSD
scatter(stopBehTable.SSDx,stopBehTable.pNC,'Filled','MarkerFaceAlpha',0.5)
% Then plot the extrapolated weibull-fitted inhibition function
[~,~,inhFunc.x,inhFunc.y] =...
    SEF_Toolbox_FitWeibull(stopBehTable.SSDx, stopBehTable.pNC, stopBehTable.nTrl);
plot(inhFunc.x,inhFunc.y,'k')
% ...and label the axes!
xlabel('Stop-signal delay (ms)'); ylabel('P(Respond | Stop-Signal)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%### pNC/SSD and Conflict relationship ########################
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,3,6); hold on
% Produce a bar chart showing the conflict activation (a.u) for each
% SSD/pNC index.
bar([1:length(SSDconflict.SSD)],SSDconflict.windowAverage_conflict,'FaceColor',colors.noncanc)
% ...and label the axes!
xlabel('P(Respond | Stop-Signal)'); ylabel('Conflict (a.u.)'); 


% Running this code will generate all the time-depth plots in the
% manuscript. Here we are plotting them in the sequence they appear in the
% manuscript and then the supplementary information:

% Outputs are the following figures:
% figure 2 (Matlab output) - corresponds to Figure 2 in manuscript
% figure 3 (Matlab output) - corresponds to Figure 3 in manuscript
% figure 4 (Matlab output) - corresponds to Figure 4 in manuscript
% figure 1004 (Matlab output) - corresponds to Supplementary Figure 4 in manuscript
% figure 1005 (Matlab output) - corresponds to Supplementary Figure 5 in manuscript
% figure 1006 (Matlab output) - corresponds to Supplementary Figure 6 in manuscript

%%%%% Parameters common to all figures:

timeRange = [-250 600]; % The time-range of interest for plotting time-depth plot
samplingBias_flag = 1; % if 1 it means we want to correct for uneven sampling distribution.

%%%%% Loading data used for all figures:
[codeFolder, dataFolder] = FolderInfo();
load([dataFolder '\spk_ModulationTiming.mat'])
load([dataFolder '\neuronInfo_perClass.mat'])

%% %%%%%%%%%%%%%  Figures in the main text:
% Figure 2:
neuronType = 'Conflict';
modTimes = [spk_ModulationTiming.reTONE.rawSDF.(neuronType).onset, ...
    spk_ModulationTiming.reTONE.rawSDF.(neuronType).offset];
% convert modTimes to the range we want to view:
modTimes( modTimes(:,1) < timeRange(1), 1 ) = timeRange(1);
modTimes( modTimes(:,2) > timeRange(2), 2 ) = timeRange(2);
neuronInfo = neuronInfo_perClass.(neuronType);
Color_RGB = [.8 .4 0.1];
h_timeDepth.(neuronType) = figure;
subplot(5,2,1)
[recruitmentData.(neuronType)] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
title(['Figure 3a - n = ' int2str( size(neuronInfo,1) ) ])
ylim([0 1])
xlim(timeRange);
% h_timeDepthPlot.(neuronType) = figure;
subplot(5,2,[5 7 9])
[depthArray.(neuronType), depthMatrix.(neuronType)] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
title(['Figure 3b - n = ' int2str( sum( ~isnan(neuronInfo.depth_idx)  & ~isnan(spk_ModulationTiming.reTONE.rawSDF.(neuronType).onset) ) ) ])
xlabel( 'Time from TONE (ms)' )


% Figure 3:
neuronType = 'EventTiming';
modTimes = [spk_ModulationTiming.reTONE.rawSDF.(neuronType).onset, ...
    spk_ModulationTiming.reTONE.rawSDF.(neuronType).offset];
% convert modTimes to the range we want to view:
modTimes( modTimes(:,1) < timeRange(1), 1 ) = timeRange(1);
modTimes( modTimes(:,2) > timeRange(2), 2 ) = timeRange(2);
neuronInfo = neuronInfo_perClass.(neuronType);
Color_RGB = [0 0 0.4];
h_timeDepth.(neuronType) = figure;
subplot(5,2,1)
[recruitmentData.(neuronType)] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
title(['Figure 4a - n = ' int2str( size(neuronInfo,1) ) ])
ylim([0 1])
xlim(timeRange);
% h_timeDepthPlot.(neuronType) = figure;
subplot(5,2,[5 7 9])
[depthArray.(neuronType), depthMatrix.(neuronType)] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
title(['Figure 4b - n = ' int2str( sum( ~isnan(neuronInfo.depth_idx)  & ~isnan(spk_ModulationTiming.reTONE.rawSDF.(neuronType).onset) ) ) ])
xlabel( 'Time from TONE (ms)' )



% Figure 4:
neuronType = 'GoalMaintenance';
modTimes = [spk_ModulationTiming.reTONE.rawSDF.(neuronType).onset, ...
    spk_ModulationTiming.reTONE.rawSDF.(neuronType).offset];
% convert modTimes to the range we want to view:
modTimes( modTimes(:,1) < timeRange(1), 1 ) = timeRange(1);
modTimes( modTimes(:,2) > timeRange(2), 2 ) = timeRange(2);
neuronInfo = neuronInfo_perClass.(neuronType);
Color_RGB = [0.4 0 0];
h_timeDepth.(neuronType) = figure;
subplot(5,2,1)
[recruitmentData.(neuronType)] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
title(['Figure 5a - n = ' int2str( size(neuronInfo,1) ) ])
ylim([0 1])
xlim(timeRange);
% h_timeDepthPlot.(neuronType) = figure;
subplot(5,2,[5 7 9])
[depthArray.(neuronType), depthMatrix.(neuronType)] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
title(['Figure 5b - n = ' int2str( sum( ~isnan(neuronInfo.depth_idx)  & ~isnan(spk_ModulationTiming.reTONE.rawSDF.(neuronType).onset) ) ) ])
xlabel( 'Time from TONE (ms)' )
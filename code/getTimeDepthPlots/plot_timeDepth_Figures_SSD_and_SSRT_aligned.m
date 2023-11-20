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
timeRange_fig5 = [-400 750]; % The time-range of interest for plotting time-depth plot
samplingBias_flag = 1; % if 1 it means we want to correct for uneven sampling distribution.

%%%%% Loading data used for all figures:
[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\spk_ModulationTiming.mat'])
load([dataFolder '\neuronInfo_perClass.mat'])

%% %%%%%%%%%%%%%  Figures in the main text:
% Figure 2:
neuronType = 'Conflict';
modTimes = [spk_ModulationTiming.reSSRT.differenceFunction.(neuronType).onset, ...
    spk_ModulationTiming.reSSRT.differenceFunction.(neuronType).offset];
neuronInfo = neuronInfo_perClass.(neuronType);
Color_RGB = [.8 .4 0.1];
h_timeDepth.(neuronType) = figure(2);
subplot(5,2,1)
[recruitmentData.(neuronType)] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
title(['Figure 3a - n = ' int2str( size(neuronInfo,1) ) ])
% h_timeDepthPlot.(neuronType) = figure;
subplot(5,2,[5 7 9])
[depthArray.(neuronType), depthMatrix.(neuronType)] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
title(['Figure 3b - n = ' int2str( sum(~isnan(neuronInfo.depth_idx)) ) ])
xlabel( 'Time from SSRT (ms)' )

% Figure 3:
neuronType = 'EventTiming';
modTimes = [spk_ModulationTiming.reSSRT.differenceFunction.(neuronType).onset, ...
    spk_ModulationTiming.reSSRT.differenceFunction.(neuronType).offset];
neuronInfo = neuronInfo_perClass.(neuronType);
Color_RGB = [0 0 0.4];
h_timeDepth.(neuronType) = figure(3);
subplot(5,2,1)
[recruitmentData.(neuronType)] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
title(['Figure 4a - n = ' int2str( size(neuronInfo,1) ) ])
% h_timeDepthPlot.(neuronType) = figure;
subplot(5,2,[5 7 9])
[depthArray.(neuronType), depthMatrix.(neuronType)] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
title(['Figure 4b - n = ' int2str( sum(~isnan(neuronInfo.depth_idx)) ) ])
xlabel( 'Time from SSRT (ms)' )


% Figure 4:
neuronType = 'GoalMaintenance';
modTimes = [spk_ModulationTiming.reSSRT.differenceFunction.(neuronType).onset, ...
    spk_ModulationTiming.reSSRT.differenceFunction.(neuronType).offset];
neuronInfo = neuronInfo_perClass.(neuronType);
Color_RGB = [0.4 0 0];
h_timeDepth.(neuronType) = figure(4);
subplot(5,2,1)
[recruitmentData.(neuronType)] = getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
title(['Figure 5a - n = ' int2str( size(neuronInfo,1) ) ])
% h_timeDepthPlot.(neuronType) = figure;
subplot(5,2,[5 7 9])
[depthArray.(neuronType), depthMatrix.(neuronType)] = getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
title(['Figure 5b - n = ' int2str( sum(~isnan(neuronInfo.depth_idx)) ) ])
xlabel( 'Time from SSRT (ms)' )

%% %%%%%%%%%%%%%  Figures in the Supplementary Section %%%%%%%%%%%%%%%%%%%

% In this section, we are doing time-depth and recruitment plots relative
% to different alignments.

neuronType = 'Conflict';
alignmentList = {'reSSD', 'reSSRT', 'reSSRTbeest'};
h_timeDepth_Supplementary.(neuronType) = figure(1004);
for alignmentIdx = 1:numel(alignmentList)
    alignment = alignmentList{alignmentIdx};
    modTimes = [spk_ModulationTiming.(alignment).differenceFunction.(neuronType).onset, ...
        spk_ModulationTiming.(alignment).differenceFunction.(neuronType).offset];
    neuronInfo = neuronInfo_perClass.(neuronType);
    Color_RGB = [.8 .4 0.1];
    subplot(5,3, 1 + (alignmentIdx-1)  )
    getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
    title(['Supp.Fig 4a - n = ' int2str( size(neuronInfo,1) ) ])
    subplot(5 , 3, [7 10 13] + (alignmentIdx-1)  )
    getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
    title(['Supp.Fig 4a - n = ' int2str( sum(~isnan(neuronInfo.depth_idx)) ) ])
    xlabel([ 'Time from ' alignment(3:end) ' (ms)' ])
end


neuronType = 'EventTiming';
alignmentList = {'reSSD', 'reSSRT', 'reSSRTbeest'};
h_timeDepth_Supplementary.(neuronType) = figure(1005);
for alignmentIdx = 1:numel(alignmentList)
    modTimes = [];
    alignment = alignmentList{alignmentIdx};
    modTimes = [spk_ModulationTiming.(alignment).differenceFunction.(neuronType).onset, ...
        spk_ModulationTiming.(alignment).differenceFunction.(neuronType).offset];
    neuronInfo = neuronInfo_perClass.(neuronType);
    Color_RGB = [0.3 0.3 0.6];
    subplot(5,3, 1 + (alignmentIdx-1)  )
    getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
    title(['Supp.Fig 5a - n = ' int2str( size(neuronInfo,1) ) ])
    % h_timeDepthPlot.(neuronType) = figure;
    subplot(5 , 3, [7 10 13] + (alignmentIdx-1)  )
    getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
    title(['Supp.Fig 5a - n = ' int2str( sum(~isnan(neuronInfo.depth_idx)) ) ])
    xlabel([ 'Time from ' alignment(3:end) ' (ms)' ])
end


neuronType = 'GoalMaintenance';
alignmentList = {'reSSD', 'reSSRT', 'reSSRTbeest'};
h_timeDepth_Supplementary.(neuronType) = figure(1006);
for alignmentIdx = 1:numel(alignmentList)
    modTimes = [];
    alignment = alignmentList{alignmentIdx};
    modTimes = [spk_ModulationTiming.(alignment).differenceFunction.(neuronType).onset, ...
        spk_ModulationTiming.(alignment).differenceFunction.(neuronType).offset];
    neuronInfo = neuronInfo_perClass.(neuronType);
    Color_RGB = [0.9 0.3 0.4];
    subplot(5,3, 1 + (alignmentIdx-1)  )
    getRecruitmentPlot(modTimes, timeRange, neuronInfo, Color_RGB);
    title(['Supp.Fig 6a - n = ' int2str( size(neuronInfo,1) ) ])
    % h_timeDepthPlot.(neuronType) = figure;
    subplot(5 , 3, [7 10 13] + (alignmentIdx-1)  )
    getTimeDepthPlot(modTimes, timeRange, neuronInfo, samplingBias_flag, Color_RGB);
    title(['Supp.Fig 6a - n = ' int2str( sum(~isnan(neuronInfo.depth_idx)) ) ])
    xlabel([ 'Time from ' alignment(3:end) ' (ms)' ])
end


h_fig5b = figure;
neuronTypeList = {'GoalMaintenance', 'Conflict', 'EventTiming'};
colorSet = { [0.4 0 0], [.8 .4 0.1], [0 0 0.4] };
alignment = 'reSSD';
for neuronTypeIdx = 1:numel(neuronTypeList)
    neuronType = neuronTypeList{neuronTypeIdx};
    modTimes = [];
    modTimes = [spk_ModulationTiming.(alignment).differenceFunction.(neuronType).onset, ...
        spk_ModulationTiming.(alignment).differenceFunction.(neuronType).offset];
    neuronInfo = neuronInfo_perClass.(neuronType);
    Color_RGB = colorSet{neuronTypeIdx};
    spkDivide_flag = 0;
    getRecruitmentPlot(modTimes, timeRange_fig5, neuronInfo, Color_RGB, spkDivide_flag); hold on;
    title(['Fig 6b'])
    xlabel( 'Time from Stop-signal (ms)' )
    % h_timeDepthPlot.(neuronType) = figure;
end



clear Color_RGB alignment alignmentIdx alignmentList 
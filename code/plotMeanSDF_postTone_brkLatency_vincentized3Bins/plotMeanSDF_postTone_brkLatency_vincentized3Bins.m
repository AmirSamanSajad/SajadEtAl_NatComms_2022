% Load the data file containing relevant information:
[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\postTone_spiking_vs_behavior.mat'])
% In supplementary Fig 5 and Supplementary Fig 6, post-tone activity for
% two types of neurons (neuronType) is shown:
timeRange = [-200:600];
Refindex = 500;
timeRangeIdx = timeRange + Refindex;
neuronTypeList = {     'GoalMaintenance',        'Supp. Fig 6c';
                  'EventTiming_preToneActivity', 'Supp. Fig 5c'};
representativeSessionIdx = [ 2  2 ]; % session index 1 picked just to show latency dist histogram.
for TypeIdx = 1:size(neuronTypeList,1)
    neuronType = neuronTypeList{TypeIdx,1};
    figure(1000)
    % Plotting a representative Fixation break histogram:
    subplot( 3, size(neuronTypeList,1), TypeIdx )
    % let's pick a representative session:
    bar( 0:10:600, BreakLatencyHist_allSession.(neuronType).Bin1(representativeSessionIdx(TypeIdx),:) , 'FaceColor', [0.7, 0.7 , 0.7] ); hold on;
    bar( 0:10:600, BreakLatencyHist_allSession.(neuronType).Bin2(representativeSessionIdx(TypeIdx),:) , 'FaceColor', [0.3, 0.3 , 0.3]   ); hold on;
    bar( 0:10:600, BreakLatencyHist_allSession.(neuronType).Bin3(representativeSessionIdx(TypeIdx),:) , 'FaceColor', [0.0, 0.0 , 0.0]   ); hold on;
    xlim([timeRange(1) timeRange(end)])
    yticks([])
    vline(0, 'k-') % tone time
    xlabel( 'Fix Break Time' )
    ylabel( 'Trial frequency' )
    title( {[neuronTypeList{TypeIdx,2}], ['early-, mid-, late- post-Tone fix break dist']} )
    % plotting the mean SDF for each latency bin:
    subplot( 2,  size(neuronTypeList,1), TypeIdx +  size(neuronTypeList,1) )
    plot( timeRange, mean(sdf_tone_fixBrk_latencyBins.(neuronType).postTone_BrkLat_bin1(:,timeRangeIdx) ), '-', 'color', [0.7 0.7 0.7]); hold on;
    plot( timeRange, mean(sdf_tone_fixBrk_latencyBins.(neuronType).postTone_BrkLat_bin2(:,timeRangeIdx) ), '-', 'color', [0.3 0.3 0.3]);
    plot( timeRange, mean(sdf_tone_fixBrk_latencyBins.(neuronType).postTone_BrkLat_bin3(:,timeRangeIdx) ), '-', 'color', [0 0 0]);
%     ylim( [0 15] )
    title( {[neuronTypeList{TypeIdx,2}], ['Peri-Tone activity for'], ['early-, mid-, late- post-Tone fix break']} )
    xlabel( 'Time from tone (ms)' )
    ylabel( 'mean firing rate (spk/sec)' )
    vline(0, 'k-') % tone time
    vline(600, 'k-') % reward time
    xlim([timeRange(1) timeRange(end)])
end
%%


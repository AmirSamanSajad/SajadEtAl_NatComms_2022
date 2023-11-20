[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\SDFsupplementaryData.mat'])

SSDforPlot.Canceled = 'SSD2';
SSDforPlot.Diff_Canceled_noStop = 'SSD2';
SSDforPlot.Diff_Canceled_Noncanceled = 'SSDall'; % because there are not that many non-canceled trials for SSD1 or SSD2.

normWindow = -200:300; % note that 500 is the
normWindowIndex = find(timeAxis == normWindow(1), 1): find(timeAxis == normWindow(end), 1);

%%%%%%%%%%%%%%%%% Left panels: aligned on SSRT - only canceled trials:
trialType = 'canceled';
SSDforPlotTag = 'Canceled';
alignment = 'SSRTaligned';
signalType = 'raw';
% The procedure here normalizes the plots to their peak = 1.%%%%% 

% top panel (conflict neurons):
neuronType = 'Conflict';
SDFdata_heatmap.([trialType '_' alignment '_' neuronType]) = ...
    SDFdata.(signalType).(alignment).(neuronType).(trialType).(SSDforPlot.Canceled) ./ ... 
    repmat( max( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) )(:, normWindowIndex)' )', 1, size( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) ), 2 ) );
% middle panel (GoalMaintenance neurons):
neuronType = 'GoalMaintenance';
SDFdata_heatmap.([trialType '_' alignment '_' neuronType]) = ...
    SDFdata.(signalType).(alignment).(neuronType).(trialType).(SSDforPlot.Canceled) ./ ... 
    repmat( max( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) )(:, normWindowIndex)' )', 1, size( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) ), 2 ) );
% lower panel (EventTiming neurons):
neuronType = 'EventTiming';
SDFdata_heatmap.([trialType '_' alignment '_' neuronType]) = ...
    SDFdata.(signalType).(alignment).(neuronType).(trialType).(SSDforPlot.Canceled) ./ ... 
    repmat( max( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) )(:, normWindowIndex)' )', 1, size( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) ), 2 ) );

% Let's plot now:
neuronTypeList = {'Conflict', 'GoalMaintenance', 'EventTiming'};

figure
for neuronTypeIdx = 1:numel(neuronTypeList)
    neuronType = neuronTypeList{neuronTypeIdx};
    subplot(3,4,1 + (neuronTypeIdx-1)*4 )
    imagesc( SDFdata_heatmap.([trialType '_' alignment '_' neuronType])(:, 1:1300) )
    xticks([1 501 1001]); xticklabels([-500 0 500])
    vline(501, 'k-')
    caxis( [ 0 1 ] )
    title( [neuronType ' neurons'] )
end
xlabel( 'Time from SSRT (ms)' )
sgtitle('left panels')

%%%%%%%%%%%%%%%%% 2nd left panel: aligned on TONE - only canceled trials:
trialType = 'canceled';
SSDforPlotTag = 'Canceled';
alignment = 'TONEaligned';
signalType = 'raw';
% The procedure here normalizes the plots to their peak = 1.%%%%% 

% top panel (conflict neurons):
neuronType = 'Conflict';
SDFdata_heatmap.([trialType '_' alignment '_' neuronType]) = ...
    SDFdata.(signalType).(alignment).(neuronType).(trialType).(SSDforPlot.Canceled) ./ ... 
    repmat( max( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) )(:, normWindowIndex)' )', 1, size( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) ), 2 ) );
% middle panel (GoalMaintenance neurons):
neuronType = 'GoalMaintenance';
SDFdata_heatmap.([trialType '_' alignment '_' neuronType]) = ...
    SDFdata.(signalType).(alignment).(neuronType).(trialType).(SSDforPlot.Canceled) ./ ... 
    repmat( max( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) )(:, normWindowIndex)' )', 1, size( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) ), 2 ) );
% lower panel (EventTiming neurons):
neuronType = 'EventTiming';
SDFdata_heatmap.([trialType '_' alignment '_' neuronType]) = ...
    SDFdata.(signalType).(alignment).(neuronType).(trialType).(SSDforPlot.Canceled) ./ ... 
    repmat( max( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) )(:, normWindowIndex)' )', 1, size( SDFdata.(signalType).(alignment).(neuronType).(trialType).( SSDforPlot.(SSDforPlotTag) ), 2 ) );

% Let's plot now:
neuronTypeList = {'Conflict', 'GoalMaintenance', 'EventTiming'};
figure
for neuronTypeIdx = 1:numel(neuronTypeList)
    neuronType = neuronTypeList{neuronTypeIdx};
    subplot(3,4,1 + (neuronTypeIdx-1)*4 )
    imagesc( SDFdata_heatmap.([trialType '_' alignment '_' neuronType])(:, 1:900) )
    xticks([1 501 900]); xticklabels([-500 0 400])
    vline(501, 'k-')
    caxis( [ 0 1 ] )
    title( [neuronType ' neurons'] )
end
xlabel( 'Time from feedback tone (ms)' )
sgtitle('left panels')

%%%%%%%%%%%%%%%%% 2nd right panel: aligned on SSRT - difference between canceled and no-stop trials:
trialType1 = 'canceled';
trialType2 = 'noStop_latencyMatched';
SSDforPlotTag = 'Diff_Canceled_noStop';
alignment = 'SSRTaligned';
signalType = 'raw';
% The procedure here normalizes the plots to their peak = 1.%%%%% 
% top panel (conflict neurons):
neuronType = 'Conflict';
SDFDIFFdata = SDFdata.(signalType).(alignment).(neuronType).(trialType1).(SSDforPlot.(SSDforPlotTag)) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).(SSDforPlot.(SSDforPlotTag));
SDFdata_heatmap.(['difference_' trialType1 '_' trialType2 '_' alignment '_' neuronType]) = ...
    SDFDIFFdata ./ ... 
    repmat( max( abs(SDFDIFFdata(:, normWindowIndex))' )', 1, size( SDFDIFFdata, 2 ) );
% middle panel (GoalMaintenance neurons):
neuronType = 'GoalMaintenance';
SDFDIFFdata = SDFdata.(signalType).(alignment).(neuronType).(trialType1).(SSDforPlot.(SSDforPlotTag)) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).(SSDforPlot.(SSDforPlotTag));
SDFdata_heatmap.(['difference_' trialType1 '_' trialType2 '_' alignment '_' neuronType]) = ...
    SDFDIFFdata ./ ... 
    repmat( max( abs(SDFDIFFdata(:, normWindowIndex))' )', 1, size( SDFDIFFdata, 2 ) );
% lower panel (EventTiming neurons):
neuronType = 'EventTiming';
SDFDIFFdata = SDFdata.(signalType).(alignment).(neuronType).(trialType1).(SSDforPlot.(SSDforPlotTag)) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).(SSDforPlot.(SSDforPlotTag));
SDFdata_heatmap.(['difference_' trialType1 '_' trialType2 '_' alignment '_' neuronType]) = ...
    SDFDIFFdata ./ ... 
    repmat( max( abs(SDFDIFFdata(:, normWindowIndex))' )', 1, size( SDFDIFFdata, 2 ) );
% Let's plot now:
neuronTypeList = {'Conflict', 'GoalMaintenance', 'EventTiming'};
figure
for neuronTypeIdx = 1:numel(neuronTypeList)
    neuronType = neuronTypeList{neuronTypeIdx};
    subplot(3,4,1 + (neuronTypeIdx-1)*4 )
    imagesc( SDFdata_heatmap.(['difference_' trialType1 '_' trialType2  '_' alignment '_' neuronType])(:, 1:1300) )
    xticks([1 501 1001]); xticklabels([-500 0 500])
    vline(501, 'k-')
    caxis( [ -1 1 ] )
    title( [neuronType ' neurons'] )
end
xlabel( 'Time from SSRT (ms)' )
sgtitle('right panels')

%%%%%%%%%%%%%%%%% right-most panels: aligned on SSRT - difference between canceled and non-canceled trials:
trialType1 = 'canceled';
trialType2 = 'noncanceled';
SSDforPlotTag = 'Canceled';
alignment = 'SSRTaligned';
signalType = 'raw';
% The procedure here normalizes the plots to their peak = 1.%%%%% 

% top panel (conflict neurons):
neuronType = 'Conflict';
clear SDFDIFFdata
SDFDIFFdata = SDFdata.(signalType).(alignment).(neuronType).(trialType1).(SSDforPlot.(SSDforPlotTag)) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).(SSDforPlot.(SSDforPlotTag));
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD3(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSD3(ii,:);
    end
end
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD1(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSD1(ii,:);
    end
end
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD1(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSDall(ii,:);
    end
end
SDFdata_heatmap.(['difference_' trialType1 '_' trialType2 '_' alignment '_' neuronType]) = ...
    SDFDIFFdata ./ ... 
    repmat( max( abs(SDFDIFFdata(:, normWindowIndex)' ))', 1, size( SDFDIFFdata, 2 ) );


% middle panel (GoalMaintenance neurons):
neuronType = 'GoalMaintenance';
clear SDFDIFFdata
SDFDIFFdata = SDFdata.(signalType).(alignment).(neuronType).(trialType1).(SSDforPlot.(SSDforPlotTag)) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).(SSDforPlot.(SSDforPlotTag));
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD3(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSD3(ii,:);
    end
end
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD1(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSD1(ii,:);
    end
end
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD1(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSDall(ii,:);
    end
end
SDFdata_heatmap.(['difference_' trialType1 '_' trialType2 '_' alignment '_' neuronType]) = ...
    SDFDIFFdata ./ ... 
    repmat( max( abs(SDFDIFFdata(:, normWindowIndex))' )', 1, size( SDFDIFFdata, 2 ) );

% lower panel (EventTiming neurons):
neuronType = 'EventTiming';
clear SDFDIFFdata
SDFDIFFdata = SDFdata.(signalType).(alignment).(neuronType).(trialType1).(SSDforPlot.(SSDforPlotTag)) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).(SSDforPlot.(SSDforPlotTag));
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD3(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSD3(ii,:);
    end
end
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD1(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSD1(ii,:);
    end
end
for ii = 1:size(SDFDIFFdata,1)
    if isnan(SDFDIFFdata(ii,1) ) == 1
        SDFDIFFdata(ii,:) = SDFdata.(signalType).(alignment).(neuronType).(trialType1).SSD1(ii,:) - SDFdata.(signalType).(alignment).(neuronType).(trialType2).SSDall(ii,:);
    end
end
SDFdata_heatmap.(['difference_' trialType1 '_' trialType2 '_' alignment '_' neuronType]) = ...
    SDFDIFFdata ./ ... 
    repmat( max( abs(SDFDIFFdata(:, normWindowIndex)' ))', 1, size( SDFDIFFdata, 2 ) );


% Let's plot now:
neuronTypeList = {'Conflict', 'GoalMaintenance', 'EventTiming'};
figure
for neuronTypeIdx = 1:numel(neuronTypeList)
    neuronType = neuronTypeList{neuronTypeIdx};
    subplot(3,4,1 + (neuronTypeIdx-1)*4 )
    imagesc( SDFdata_heatmap.(['difference_' trialType1 '_' trialType2  '_' alignment '_' neuronType])(:, 1:1300) )
    xticks([1 501 1001]); xticklabels([-500 0 500])
    vline(501, 'k-')
    caxis( [ -1 1 ] )
    xlabel( 'Time from SSRT (ms)' )
    title( [neuronType ' neurons'] )
end
sgtitle('right panels')
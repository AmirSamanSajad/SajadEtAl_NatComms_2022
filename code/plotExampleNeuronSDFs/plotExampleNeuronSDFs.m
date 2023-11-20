[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\SDFdata.mat'])

figure;
neuronIDs = [308, 339];
neuronType = 'Conflict'; figNum = 2;
SSDlist = {'SSD1', 'SSD2', 'SSD3'};
for n = 1:numel(neuronIDs)
    neuronIdx = find(neuronID.primaryClass.(neuronType) == neuronIDs(n));
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        SDF_C.(SSD) = SDFdata.raw.SSRTaligned.(neuronType).canceled.(SSD)( neuronIdx , : );
        SDF_nS.(SSD) = SDFdata.raw.SSRTaligned.(neuronType).noStop_latencyMatched.(SSD)( neuronIdx , : );
        lineColor = [0.7 0.7 0.7] - ([0.35 0.35 0.35]*(SSDidx-1));
        subplot(2,2, 1 + (n-1)*2 )
        plot( timeAxis, SDF_C.(SSD), '-', 'lineWidth', 3, 'color', lineColor); hold on;
        plot( timeAxis, SDF_nS.(SSD), '-', 'lineWidth', 0.5, 'color', lineColor); hold on;
    end
    xlim( [timeAxis(1) timeAxis(end)] )
    ylabel( 'Firing rate (spk/sec)' )
    xlabel( 'Time from SSRT (ms)' )
end
sgtitle( {['Fig ' int2str(figNum)], [neuronType ' neuron examples'] }) 


figure;
neuronIDs = [378];
neuronType = 'EventTiming'; figNum = 3;
SSDlist = {'SSD1', 'SSD2', 'SSD3'};
for n = 1:numel(neuronIDs)
    neuronIdx = find(neuronID.primaryClass.(neuronType) == neuronIDs(n));
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        SDF_C.(SSD) = SDFdata.raw.SSRTaligned.(neuronType).canceled.(SSD)( neuronIdx , : );
        SDF_nS.(SSD) = SDFdata.raw.SSRTaligned.(neuronType).noStop_latencyMatched.(SSD)( neuronIdx , : );
        lineColor = [0.7 0.7 0.7] - ([0.35 0.35 0.35]*(SSDidx-1));
        h1 = subplot(2,2, 1 + (n-1)*2 )
        plot( timeAxis, SDF_C.(SSD), '-', 'lineWidth', 3, 'color', lineColor); hold on;
        plot( timeAxis, SDF_nS.(SSD), '-', 'lineWidth', 0.5, 'color', lineColor); hold on;
    end
    xlim( [timeAxis(1) timeAxis(end)] )
    ylabel( 'Firing rate (spk/sec)' )
    xlabel( 'Time from SSRT (ms)' )
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        SDF_C.(SSD) = SDFdata.raw.TONEaligned.(neuronType).canceled.(SSD)( neuronIdx , : );
        SDF_nS.(SSD) = SDFdata.raw.TONEaligned.(neuronType).noStop_latencyMatched.(SSD)( neuronIdx , : );
        lineColor = [0.7 0.7 0.7] - ([0.35 0.35 0.35]*(SSDidx-1));
        h2 = subplot(2,2, 2 + (n-1)*2 )
        plot( timeAxis, SDF_C.(SSD), '-', 'lineWidth', 3, 'color', lineColor); hold on;
        plot( timeAxis, SDF_nS.(SSD), '-', 'lineWidth', 0.5, 'color', lineColor); hold on;
    end
    xlim( [timeAxis(1) timeAxis(end)] )
    ylabel( 'Firing rate (spk/sec)' )
    xlabel( 'Time from SSRT (ms)' )
    linkaxes([h1, h2], 'y')
end
sgtitle( {['Fig ' int2str(figNum)], [neuronType ' neuron examples'] }) 



figure;
neuronIDs = [468 399];
neuronType = 'GoalMaintenance'; figNum = 4;
SSDlist = {'SSD1', 'SSD2', 'SSD3'};
for n = 1:numel(neuronIDs)
    neuronIdx = find(neuronID.primaryClass.(neuronType) == neuronIDs(n));
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        SDF_C.(SSD) = SDFdata.raw.SSRTaligned.(neuronType).canceled.(SSD)( neuronIdx , : );
        SDF_nS.(SSD) = SDFdata.raw.SSRTaligned.(neuronType).noStop_latencyMatched.(SSD)( neuronIdx , : );
        lineColor = [0.7 0.7 0.7] - ([0.35 0.35 0.35]*(SSDidx-1));
        h1 = subplot(2,2, 1 + (n-1)*2 )
        plot( timeAxis, SDF_C.(SSD), '-', 'lineWidth', 3, 'color', lineColor); hold on;
        plot( timeAxis, SDF_nS.(SSD), '-', 'lineWidth', 0.5, 'color', lineColor); hold on;
    end
    xlim( [timeAxis(1) timeAxis(end)] )
    ylabel( 'Firing rate (spk/sec)' )
    xlabel( 'Time from SSRT (ms)' )
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        SDF_C.(SSD) = SDFdata.raw.TONEaligned.(neuronType).canceled.(SSD)( neuronIdx , : );
        SDF_nS.(SSD) = SDFdata.raw.TONEaligned.(neuronType).noStop_latencyMatched.(SSD)( neuronIdx , : );
        lineColor = [0.7 0.7 0.7] - ([0.35 0.35 0.35]*(SSDidx-1));
        h2 = subplot(2,2, 2 + (n-1)*2 )
        plot( timeAxis, SDF_C.(SSD), '-', 'lineWidth', 3, 'color', lineColor); hold on;
        plot( timeAxis, SDF_nS.(SSD), '-', 'lineWidth', 0.5, 'color', lineColor); hold on;
    end
    xlim( [timeAxis(1) timeAxis(end)] )
    ylabel( 'Firing rate (spk/sec)' )
    xlabel( 'Time from SSRT (ms)' )
    linkaxes([h1, h2], 'y')
end
sgtitle( {['Fig ' int2str(figNum)], [neuronType ' neuron examples'] }) 
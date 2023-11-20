[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
% This contains the SDF data:
load([dataFolder '\SDFsupplementaryData.mat'])
% This contains information about different neuron classes:
load([dataFolder '\neuronInfo_perClass.mat'])
%% Supplementary Figure 2b:
    %  plots the SDF on canceled, no-stop, and
    % non-canceled error trials. Because error neurons show differential
    % activity between non-canceled and no-stop trials, we have separated
    % neurons in each class into non-Error and Error neuron subclasses and show
    % the SDF for each separately.
    % This figure makes the point that the comparison between canceled and
    % non-canceled trials for studying neural dynamics involved in response
    % inhibition is not appropriate. This is because canceled and non-canceld trials
    % have inherently different temporal dynamics with non-canceled trials
    % being fast and canceled trials being slow (Supp Fig 2a shows this). The
    % other reason, as illustrated in Supp. Fig 2b. is that some neurons can
    % exhibit Error-related responses (as shown in neurons in the bottom row)
    % and that can ambiguate whether the difference between canceled and non-canceled trials
    % is due to stopping process or due to error component.
    
    neuronTypeList = {'Conflict', 'GoalMaintenance', 'EventTiming'};
    canceled_SSD = 'SSD2'; % SSD2 is the sweet spot for comparison with non-canceled trials because 
                           % there are enough canceled trials in this bin and it's closer to the SSD 
                           % at which most non-canceled trials occur. SSD3 would even be closer in time 
                           % to SSD at which noncanceled trials occur, but there are fewer canceled 
                           %trials in that bin.
    noStop_latencyMatched_SSD = 'SSD2'; % Just latency-matching to canceled trials.
    noncanceled_SSD = 'SSDall';  % The results are very similar if you pick SSD2 or SSDall. 
                                 % SSDall has the benefit that there are more trials.
    figure
    for neuronTypeIdx = 1:numel(neuronTypeList)
      neuronType = neuronTypeList{neuronTypeIdx};
      subplot(2,3,1 + (neuronTypeIdx-1) )
        % For canceled and no-stop trials we plot SSD1.
        plot( timeAxis, mean( SDFdata.raw.SSRTaligned.(neuronType).canceled.(canceled_SSD)( neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 0 , : )), 'k-', 'linewidth', 3 ); hold on;
        plot( timeAxis, mean( SDFdata.raw.SSRTaligned.(neuronType).noStop_latencyMatched.(noStop_latencyMatched_SSD)( neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 0 , : )), 'k-', 'linewidth', 0.5 ); hold on;
        % for non-canceled trials, we need to plot the SDF for SSD3.
        % For SSD1 and SSD2, the number of error trials are too few.
        plot( timeAxis, mean( SDFdata.raw.SSRTaligned.(neuronType).noncanceled_NCerror.(noncanceled_SSD)( neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 0 , : )), 'k--', 'linewidth', 0.5 ); hold on;
        title( {[neuronType ' - nonError'], ['n = ' int2str( sum(neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 0) ) ]} )
      subplot(2,3,4 + (neuronTypeIdx-1) )
        % For canceled and no-stop trials we plot SSD1.
        plot( timeAxis, mean( SDFdata.raw.SSRTaligned.(neuronType).canceled.(canceled_SSD)( neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 1 , : )), 'k-', 'linewidth', 3 ); hold on;
        plot( timeAxis, mean( SDFdata.raw.SSRTaligned.(neuronType).noStop_latencyMatched.(noStop_latencyMatched_SSD)( neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 1 , : )), 'k-', 'linewidth', 0.5 ); hold on;
        % for non-canceled trials, we need to plot the SDF for SSD3.
        % For SSD1 and SSD2, the number of error trials are too few.
        plot( timeAxis, mean( SDFdata.raw.SSRTaligned.(neuronType).noncanceled_NCerror.(noncanceled_SSD)( neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 1 , : )), 'k--', 'linewidth', 0.5 ); hold on;
        title( {[neuronType ' - Error'], ['n = ' int2str( sum(neuronInfo_perClass.(neuronType).mod_ErrorNeuron_flag == 1) ) ]} )
    end
    sgtitle('Supp. Fig 2b') 

 %% Supplementary Figure 4b:
    % plots the SDF on 3 SSD bins for Canceled and no-stop trials:
    figure
    neuronType = 'Conflict';
    SSDlist = {'SSD1','SSD2','SSD3'};
    colorList = { 0.7*ones(1,3), 0.3*ones(1,3), 0.0*ones(1,3) };
    timeRange_SSRT = [-250:600];   timeRefIdx = 500;   timeRangeIdx_SSRT = timeRange_SSRT + timeRefIdx;
    timeRange_TONE = [-250:600];   timeRefIdx = 500;   timeRangeIdx_TONE = timeRange_TONE + timeRefIdx;
        % There are a few neurons for which SSD3 bin had too few trials for
        % a reliable SDF estimate. 
        % If you want to look at the SDF for only those neurons with
        % valid SSD3 bin value,  
    validNeurons = 1:size(neuronInfo_perClass.(neuronType),1);    % Activate this line if you want to look at all neurons with non-Nan values at each SSD bin. Suppresse the line below if this line is activated.
%     validNeurons = find( ~isnan( SDFdata.normalized.TONEaligned.(neuronType).canceled.SSD3(:,1) ) )  ;   % Activate this line if you want to look at only those neurons with non-Nan SSD3 bin. Suppresse the line above if this line is activated.
    
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        color = colorList{SSDidx};
        subplot(2,2,1)
        % There are a few neurons for which SSD3 bin had too few trials for
        % a reliable SDF estimate. So, we will use nanmean instead of mean
        % to show the population SDFs.
        % SSD1 and SSD2 population SDFs are virtually indistinguishable if
        % these neurons are excluded from the population. This is why we
        % chose to show population of all neurons with non-Nan SDF at each
        % SSD bin.
        plot( timeRange_SSRT, nanmean( SDFdata.normalized.SSRTaligned.(neuronType).canceled.(SSD)(validNeurons,timeRangeIdx_SSRT), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
        plot( timeRange_SSRT, nanmean( SDFdata.normalized.SSRTaligned.(neuronType).noStop_latencyMatched.(SSD)(validNeurons,timeRangeIdx_SSRT), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
        ylim([0 1]); xlim([timeRange_SSRT(1) timeRange_SSRT(end)])
        title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
        xlabel( 'Time from SSRT (ms)' )
        ylabel( 'Normalized firing rate' )
    
        subplot(2,2,2)
        plot( timeRange_TONE, nanmean( SDFdata.normalized.TONEaligned.(neuronType).canceled.(SSD)(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
        plot( timeRange_TONE, nanmean( SDFdata.normalized.TONEaligned.(neuronType).noStop_latencyMatched.(SSD)(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
        ylim([0 1]); xlim([timeRange_TONE(1) timeRange_TONE(end)])
        title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
        xlabel( 'Time from feedback tone (ms)' )
        ylabel( 'Normalized firing rate' )
    end
    sgtitle('Supp. Fig 4b')
 %% Supplementary Figure 5b:
    % plots the SDF on 3 SSD bins for Canceled and no-stop trials:
    figure
    neuronType = 'EventTiming';
    SSDlist = {'SSD1','SSD2','SSD3'};
    colorList = { 0.7*ones(1,3), 0.3*ones(1,3), 0.0*ones(1,3) };
    timeRange_SSRT = [-250:600];   timeRefIdx = 500;   timeRangeIdx_SSRT = timeRange_SSRT + timeRefIdx;
    timeRange_TONE = [-250:600];   timeRefIdx = 500;   timeRangeIdx_TONE = timeRange_TONE + timeRefIdx;
        % There are a few neurons for which SSD3 bin had too few trials for
        % a reliable SDF estimate. 
        % If you want to look at the SDF for only those neurons with
        % valid SSD3 bin value,  
    validNeurons = 1:size(neuronInfo_perClass.(neuronType),1);    % Activate this line if you want to look at all neurons with non-Nan values at each SSD bin. Suppresse the line below if this line is activated.
%     validNeurons = find( ~isnan( SDFdata.normalized.TONEaligned.(neuronType).canceled.SSD3(:,1) ) )  ;   % Activate this line if you want to look at only those neurons with non-Nan SSD3 bin. Suppresse the line above if this line is activated.
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        color = colorList{SSDidx};
        subplot(2,2,1)
        % There are a few neurons for which SSD3 bin had too few trials for
        % a reliable SDF estimate. So, we will use nanmean instead of mean
        % to show the population SDFs.
        % SSD1 and SSD2 population SDFs are virtually indistinguishable if
        % these neurons are excluded from the population. This is why we
        % chose to show population of all neurons with non-Nan SDF at each
        % SSD bin.
        plot( timeRange_SSRT, nanmean( SDFdata.normalized.SSRTaligned.(neuronType).canceled.(SSD)(validNeurons,timeRangeIdx_SSRT), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
        plot( timeRange_SSRT, nanmean( SDFdata.normalized.SSRTaligned.(neuronType).noStop_latencyMatched.(SSD)(validNeurons,timeRangeIdx_SSRT), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
        xlim([timeRange_SSRT(1) timeRange_SSRT(end)]);  ylim([0 1]); 
        title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
        xlabel( 'Time from SSRT (ms)' )
        ylabel( 'Normalized firing rate' )
        subplot(2,2,2)
        plot( timeRange_TONE, nanmean( SDFdata.normalized.TONEaligned.(neuronType).canceled.(SSD)(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
        plot( timeRange_TONE, nanmean( SDFdata.normalized.TONEaligned.(neuronType).noStop_latencyMatched.(SSD)(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
        xlim([timeRange_TONE(1) timeRange_TONE(end)]);  ylim([0 1]);
        title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
        xlabel( 'Time from feedback tone (ms)' )
        ylabel( 'Normalized firing rate' )
    end    
    sgtitle('Supp. Fig 5b')
  %% Supplementary Figure 6b:
    figure
    neuronType = 'GoalMaintenance';
    SSDlist = {'SSD1','SSD2','SSD3'};
    colorList = { 0.7*ones(1,3), 0.3*ones(1,3), 0.0*ones(1,3) };
    timeRange_SSRT = [-250:600];   timeRefIdx = 500;   timeRangeIdx_SSRT = timeRange_SSRT + timeRefIdx;
    timeRange_TONE = [-250:800];   timeRefIdx = 500;   timeRangeIdx_TONE = timeRange_TONE + timeRefIdx;
        % There are a few neurons for which SSD3 bin had too few trials for
        % a reliable SDF estimate. 
        % If you want to look at the SDF for only those neurons with
        % valid SSD3 bin value,  
    validNeurons = 1:size(neuronInfo_perClass.(neuronType),1);    % Activate this line if you want to look at all neurons with non-Nan values at each SSD bin. Suppresse the line below if this line is activated.
%     validNeurons = find( ~isnan( SDFdata.normalized.TONEaligned.(neuronType).canceled.SSD3(:,1) ) )  ;   % Activate this line if you want to look at only those neurons with non-Nan SSD3 bin. Suppresse the line above if this line is activated.
    for SSDidx = 1:numel(SSDlist)
        SSD = SSDlist{SSDidx};
        color = colorList{SSDidx};
        subplot(2,2,1)
        % There are a few neurons for which SSD3 bin had too few trials for
        % a reliable SDF estimate. So, we will use nanmean instead of mean
        % to show the population SDFs.
        % SSD1 and SSD2 population SDFs are virtually indistinguishable if
        % these neurons are excluded from the population. This is why we
        % chose to show population of all neurons with non-Nan SDF at each
        % SSD bin.
        plot( timeRange_SSRT, nanmean( SDFdata.normalized.SSRTaligned.(neuronType).canceled.(SSD)(validNeurons,timeRangeIdx_SSRT), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
        plot( timeRange_SSRT, nanmean( SDFdata.normalized.SSRTaligned.(neuronType).noStop_latencyMatched.(SSD)(validNeurons,timeRangeIdx_SSRT), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
        xlim([timeRange_SSRT(1) timeRange_SSRT(end)]);  ylim([0 1]); 
        title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
        xlabel( 'Time from SSRT (ms)' )
        ylabel( 'Normalized firing rate' )
        subplot(2,2,2)
        plot( timeRange_TONE, nanmean( SDFdata.normalized.TONEaligned.(neuronType).canceled.(SSD)(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
        plot( timeRange_TONE, nanmean( SDFdata.normalized.TONEaligned.(neuronType).noStop_latencyMatched.(SSD)(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
        xlim([timeRange_TONE(1) timeRange_TONE(end)]);  ylim([0 1]);
        title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
        xlabel( 'Time from feedback tone (ms)' )
        ylabel( 'Normalized firing rate' )
    end 
    sgtitle('Supp. Fig 6b')
  %% Supplementary Figure 6d:
      figure
      neuronType = 'GoalMaintenance';
      color = [0 0 0];
      timeRange_TONE = [-250:800];   timeRefIdx = 500;   timeRangeIdx_TONE = timeRange_TONE + timeRefIdx;
      % There are a few neurons for which SSD3 bin had too few trials for
      % a reliable SDF estimate.
      % If you want to look at the SDF for only those neurons with
      % valid SSD3 bin value,
      validNeurons = 1:size(neuronInfo_perClass.(neuronType),1);    % Activate this line if you want to look at all neurons with non-Nan values at each SSD bin. Suppresse the line below if this line is activated.
      %   validNeurons = find( ~isnan( SDFdata.normalized.TONEaligned.(neuronType).canceled.SSD3(:,1) ) )  ;   % Activate this line if you want to look at only those neurons with non-Nan SSD3 bin. Suppresse the line above if this line is activated.
      subplot(2,2,1)
      plot( timeRange_TONE, mean( SDFdata.raw.TONEaligned.(neuronType).canceled.SSD1(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 3, 'color', color); hold on;
      plot( timeRange_TONE, mean( SDFdata.raw.TONEaligned.(neuronType).noStop_latencyMatched.SSD1(validNeurons,timeRangeIdx_TONE), 1 ), '-', 'linewidth', 0.5, 'color', color); hold on;
      plot( timeRange_TONE, mean( SDFdata.raw.TONEaligned.(neuronType).noncanceled.SSDall(validNeurons,timeRangeIdx_TONE), 1 ), '--', 'linewidth', 0.5, 'color', color); hold on;
      xlim([timeRange_TONE(1) timeRange_TONE(end)]);
      title( {[neuronType], ['n = ' int2str( numel(validNeurons) ) ]} )
      xlabel( 'Time from feedback tone (ms)' )
      ylabel( 'Mean firing rate (spk/s)' )
      sgtitle('Supp. Fig 6d')
    
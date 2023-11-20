[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\SDFdata.mat'],  'timeAxis', 'SDFdata' )
figure;
   subplot(3,1,1)
   SSDbin = 'SSD3';  % because conflict signal is strongest for SSD3
   % note: for Conflict neurons, SSD3 has largest activity. But there can
   % be a few neurons for which the number of trials on SSD3 were too few
   % to give a reasonable estimate of SDF. Therefore we have nan'ed them,
   % and are using nanmean here.
   % the visualization is visually unaffected if we use SSD 2 or SSD 1,
   % with no nanmean.
   plot( timeAxis, nanmean( SDFdata.smooth.SSRTaligned.Conflict.canceled.(SSDbin), 1), 'k-', 'linewidth', 3 ); hold on
   plot( timeAxis, nanmean( SDFdata.smooth.SSRTaligned.Conflict.noStop_latencyMatched.(SSDbin), 1), 'k-', 'linewidth', 0.5 ); hold on
   title( 'figure 2a' )
   subplot(3,1,2)
   SSDbin = 'SSD1';
   plot( timeAxis, mean( SDFdata.smooth.SSRTaligned.EventTiming.canceled.(SSDbin), 1), 'k-', 'linewidth', 3 ); hold on
   plot( timeAxis, mean( SDFdata.smooth.SSRTaligned.EventTiming.noStop_latencyMatched.(SSDbin), 1), 'k-', 'linewidth', 0.5 ); hold on
   title( 'figure 3a' )
   subplot(3,1,3)
   SSDbin = 'SSD1';
   plot( timeAxis, mean( SDFdata.smooth.SSRTaligned.GoalMaintenance.canceled.(SSDbin), 1), 'k-', 'linewidth', 3 ); hold on
   plot( timeAxis, mean( SDFdata.smooth.SSRTaligned.GoalMaintenance.noStop_latencyMatched.(SSDbin), 1), 'k-', 'linewidth', 0.5 ); hold on
   title( 'figure 4a' )
  
    
% This code takes in the peak values for N2 and P3 components across all
% sessions and plots the related Supplementary Figures.
[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load( [dataFolder  ...
          '\ERPdata.mat' ], 'peakERP_perSession')
% This data contains peak values for 3 alignments: Stop-signal (SSD), SSRT
% calculated using the Weighted Integration Method, and SSRT calculated
% using the BEEST method. We have shared these codes in our code package as
% well.
%% plot the cumulitive ERP onset relative to each alignment:

N2peak_reSSD = peakERP_perSession.SSD_aligned.N2peak;
N2peak_reSSRTwi = peakERP_perSession.wiSSRT_aligned.N2peak;
N2peak_reSSRTbeest = peakERP_perSession.beestSSRT_aligned.N2peak;
P3peak_reSSD = peakERP_perSession.SSD_aligned.P3peak;
P3peak_reSSRTwi = peakERP_perSession.wiSSRT_aligned.P3peak;
P3peak_reSSRTbeest = peakERP_perSession.beestSSRT_aligned.P3peak;
% to compare the spread of peak values, we want the x-axis of all plots to 
% have the same range, even though the mean values are different.

xWidth = 60; % common x-axis range =  +/-xWidth

figure; 
ax1 = subplot( 2,3,1);
cdfplot( N2peak_reSSD  );
title('N2 peak time'); xlabel('time from SSD (ms)'); ylabel('p(peak < t)')
xlim( [(mean(N2peak_reSSD)-xWidth) (mean(N2peak_reSSD)+xWidth)] )
ax2 = subplot( 2,3,2);
cdfplot( N2peak_reSSRTwi  );
title('N2 peak time'); xlabel({['time from SSRT'], ['(weighted Integration method) (ms)']}); ; ylabel('p(peak < t)')
xlim( [(mean(N2peak_reSSRTwi)-xWidth) (mean(N2peak_reSSRTwi)+xWidth)] )
ax3 = subplot( 2,3,3);
cdfplot( N2peak_reSSRTbeest  );
title('N2 peak time'); xlabel({['time from SSRT'], ['(beest method) (ms)']}); ; ylabel('p(peak < t)')
xlim( [(mean(N2peak_reSSRTbeest)-xWidth) (mean(N2peak_reSSRTbeest)+xWidth)] )

ax4 = subplot( 2,3,4);
cdfplot( P3peak_reSSD  );
title('P3 peak time'); xlabel('time from SSD (ms)'); ylabel('p(peak < t)')
xlim( [(mean(P3peak_reSSD)-xWidth) (mean(P3peak_reSSD)+xWidth)] )
ax5 = subplot( 2,3,5);
cdfplot( P3peak_reSSRTwi  );
title('P3 peak time'); xlabel({['time from SSRT'], ['(weighted Integration method) (ms)']}); ; ylabel('p(peak < t)')
xlim( [(mean(P3peak_reSSRTwi)-xWidth) (mean(P3peak_reSSRTwi)+xWidth)] )
ax6 = subplot( 2,3,6);
cdfplot( P3peak_reSSRTbeest  );
title('P3 peak time'); xlabel({['time from SSRT'], ['(beest method) (ms)']}); ; ylabel('p(peak < t)')
xlim( [(mean(P3peak_reSSRTbeest)-xWidth) (mean(P3peak_reSSRTbeest)+xWidth)] )

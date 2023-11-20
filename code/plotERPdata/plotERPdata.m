[codeFolder, dataFolder] = FolderInfo() % file directory information is located here.
load([dataFolder '\ERPdata'] , 'ERPtrace_perSession', 'GrandERP', 'timeAxis')

%%%%%%%%% Code for plotting:
figure;
setSSD = 'SSD1';
plot(timeAxis, GrandERP.all.baselineCorrected.STOPSIGNALaligned.canceled.(setSSD), 'k-', 'linewidth', 3 ); hold on;
plot(timeAxis, GrandERP.all.baselineCorrected.STOPSIGNALaligned.noStop.(setSSD), 'k-', 'linewidth', 0.5 ); hold on;
set(gca,'YDir','reverse')
xlabel( 'Time from stop-signal (ms) ' )
ylabel( 'voltage (mV)' )   % NEED TO CHECK TO VERIFY
title( 'Figure 5a')
hline(0, 'k--'); vline(0, 'k-');

figure;
alignmentSet = {'TARGETaligned', 'STOPSIGNALaligned'};
alignmentLabel = {'target', 'stop-signal'};
setSSDList = {'SSD1', 'SSD2', 'SSD3'};
for alignmentIdx = 1:numel(alignmentSet)
    alignment = alignmentSet{alignmentIdx};
    for SSDidx = 1:numel(setSSDList)
        subplot( 2, 3, (alignmentIdx-1)*numel(setSSDList) + SSDidx )
        setSSD = setSSDList{SSDidx};
        color = [0.6 0.6 0.6] - (SSDidx-1)*[0.3 0.3 0.3];  % darker color for later SSDbin.
        plot(timeAxis, GrandERP.all.baselineCorrected.(alignment).canceled.(setSSD), 'k-', 'linewidth', 3, 'color', color ); hold on;
        % vERP_peak calculated based on TARGETaligned ERPs:
        vERP_peak.(setSSD) = find( GrandERP.all.baselineCorrected.TARGETaligned.canceled.(setSSD) == min( GrandERP.all.baselineCorrected.TARGETaligned.canceled.(setSSD) )  ) - find(timeAxis == 0);
        vline( vERP_peak.(setSSD)  , 'g:' )
        plot(timeAxis, GrandERP.all.baselineCorrected.(alignment).noStop.(setSSD), 'k-', 'linewidth', 0.5,  'color', color ); hold on;
        set(gca,'YDir','reverse')
        xlabel( ['Time from ' alignmentLabel{alignmentIdx} ' (ms) '] )
        ylabel( 'voltage (mV)' )
        title( 'Supplementary Figure 7a')
    end
end
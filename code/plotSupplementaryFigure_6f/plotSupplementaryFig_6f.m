% This code generates all the elements shown in Supplementary Figure 6f:
[codeFolder, dataFolder] = FolderInfo(); % file directory information is located here.
load([dataFolder '\data_SupplementaryFigure_6f.mat'])

SDF_Abort_GMneurons = Supplementary_Fig6f.SDF_GoalMaintenance.AbortTrials; % this is the spike-density function on aborted canceled trials
SDF_C_GMneurons = Supplementary_Fig6f.SDF_GoalMaintenance.Ctrials_SSDmatched; % this is the spike-density function on canceled trials
timeAxis = Supplementary_Fig6f.SDF_GoalMaintenance.timeAxis;
        % Note: we matched the SSD between aborted and non-aborted trials
        % to avoid artificial differences due to mismatched SSDs. However,
        % the number of aborted trials is significantly fewer than the
        % number of canceled trials.
SDFdiff_C_vs_Abort = SDF_Abort_GMneurons - SDF_C_GMneurons; % Obtaining the difference
z_SDFdiff_C_vs_Abort = nan( size(SDF_Abort_GMneurons) ); % initializing
for ii = 1:14
    z_SDFdiff_C_vs_Abort(ii,:) = ztransform( SDFdiff_C_vs_Abort(ii,:) ); 
    % transforming it on the Z-scale to visualize difference function for all neurons equally well.
end
figure;
subplot(25,1,[1:5])
imagesc( z_SDFdiff_C_vs_Abort )  % plotting the difference function
xlim( [0 range(timeAxis)] )

% significant difference test:
statArray = nan( 1, size(SDF_C_GMneurons, 2) ); % initializing
for ii = 1:size(SDF_C_GMneurons,2)
    statArray(1,ii) =  ttest(SDF_C_GMneurons(:,ii), SDF_Abort_GMneurons(:,ii)); % paired t-test
end

% figure;
subplot(25,1,[8 9])
imagesc(statArray); 
xlim( [0 range(timeAxis)] )

subplot(25,1,[10:20])
% error bars represent SEM's.
delta_SDF_C_GMneurons = std(SDF_C_GMneurons)/sqrt(size(SDF_C_GMneurons,1));
delta_SDF_Abort_GMneurons = std(SDF_Abort_GMneurons)/sqrt(size(SDF_Abort_GMneurons,1));
% Check out the errorBarFill.m function in Support Codes.
errorBarFill(timeAxis, mean(SDF_C_GMneurons), delta_SDF_C_GMneurons, [0 0 1], 1); hold on;
errorBarFill(timeAxis, mean(SDF_Abort_GMneurons), delta_SDF_Abort_GMneurons, [1 0 0], 1); hold on;
xlim( [timeAxis(1) timeAxis(end)] )

subplot(25,1,[21:25])
subplot(6,1,6)
hist( Supplementary_Fig6f.abortTimes, -500:50:2200 )
xlim( [timeAxis(1) timeAxis(end)] )